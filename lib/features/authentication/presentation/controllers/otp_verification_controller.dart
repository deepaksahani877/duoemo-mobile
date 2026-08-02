import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/di/injection.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/usecase/verify_otp_usecase.dart';

class OtpVerificationState {
  final bool isLoading;
  final String otpCode;
  final int resendSeconds;
  final bool canResend;
  final String? errorMessage;
  final bool isSuccess;

  const OtpVerificationState({
    this.isLoading = false,
    this.otpCode = '',
    this.resendSeconds = 45,
    this.canResend = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  OtpVerificationState copyWith({
    bool? isLoading,
    String? otpCode,
    int? resendSeconds,
    bool? canResend,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return OtpVerificationState(
      isLoading: isLoading ?? this.isLoading,
      otpCode: otpCode ?? this.otpCode,
      resendSeconds: resendSeconds ?? this.resendSeconds,
      canResend: canResend ?? this.canResend,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  String get formattedTimer {
    final minutes = (resendSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (resendSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

class OtpVerificationController extends StateNotifier<OtpVerificationState> {
  final VerifyOtpUseCase _verifyOtpUseCase;
  final LoggerService _logger;
  Timer? _timer;

  OtpVerificationController(this._verifyOtpUseCase, this._logger)
      : super(const OtpVerificationState()) {
    _startResendTimer();
  }

  void _startResendTimer() {
    _timer?.cancel();
    state = state.copyWith(resendSeconds: 45, canResend: false);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendSeconds > 1) {
        state = state.copyWith(resendSeconds: state.resendSeconds - 1);
      } else {
        timer.cancel();
        state = state.copyWith(resendSeconds: 0, canResend: true);
      }
    });
  }

  void updateOtp(String code) {
    state = state.copyWith(otpCode: code, errorMessage: null);
  }

  void resendOtp(String email) {
    if (!state.canResend) return;
    _logger.info('Resending OTP code to $email');
    _startResendTimer();
  }

  Future<void> verifyOtp(String email) async {
    if (state.otpCode.length < 6) {
      state = state.copyWith(
        errorMessage: 'Please enter the complete 6-digit OTP code',
      );
      return;
    }

    _logger.info('Verifying OTP for $email');
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final isValid = await _verifyOtpUseCase.execute(
        email: email,
        otp: state.otpCode,
      );
      if (isValid) {
        state = state.copyWith(isLoading: false, isSuccess: true);
        _logger.info('OTP verification successful');
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid OTP code. Please try again.',
        );
      }
    } catch (e, stackTrace) {
      _logger.error('Failed to verify OTP', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'OTP verification failed. Please try again.',
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final otpVerificationControllerProvider = StateNotifierProvider.autoDispose<
    OtpVerificationController, OtpVerificationState>((ref) {
  return OtpVerificationController(
    getIt<VerifyOtpUseCase>(),
    getIt<LoggerService>(),
  );
});
