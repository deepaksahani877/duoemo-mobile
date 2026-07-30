import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/di/injection.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/usecase/register_usecase.dart';

class RegisterState {
  final bool isLoading;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isAgreedToTerms;
  final String? errorMessage;
  final bool isSuccess;

  const RegisterState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isAgreedToTerms = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  RegisterState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isAgreedToTerms,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isAgreedToTerms: isAgreedToTerms ?? this.isAgreedToTerms,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class RegisterController extends StateNotifier<RegisterState> {
  final RegisterUseCase _registerUseCase;
  final LoggerService _logger;

  RegisterController(this._registerUseCase, this._logger)
      : super(const RegisterState());

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    );
  }

  void toggleTermsAgreement(bool? value) {
    state = state.copyWith(isAgreedToTerms: value ?? false);
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String dateOfBirth,
  }) async {
    if (!state.isAgreedToTerms) {
      state = state.copyWith(
        errorMessage: 'Please agree to the Terms of Service & Privacy Policy',
      );
      return;
    }

    _logger.info('Attempting registration for email: $email');
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _registerUseCase.execute(
        fullName: fullName,
        email: email,
        password: password,
        dateOfBirth: dateOfBirth,
      );
      state = state.copyWith(isLoading: false, isSuccess: true);
      _logger.info('Registration successful for email: $email');
    } catch (e, stackTrace) {
      _logger.error('Registration failed', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Registration failed. Please try again.',
      );
    }
  }
}

final registerControllerProvider =
    StateNotifierProvider.autoDispose<RegisterController, RegisterState>(
        (ref) {
  return RegisterController(
    getIt<RegisterUseCase>(),
    getIt<LoggerService>(),
  );
});
