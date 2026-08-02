import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/di/injection.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/usecase/request_password_reset_usecase.dart';

class ForgotPasswordState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const ForgotPasswordState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  final RequestPasswordResetUseCase _useCase;
  final LoggerService _logger;

  ForgotPasswordController(this._useCase, this._logger)
      : super(const ForgotPasswordState());

  Future<void> sendResetLink(String email) async {
    _logger.info('Requesting password reset link for: $email');
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _useCase.execute(email);
      state = state.copyWith(isLoading: false, isSuccess: true);
      _logger.info('Password reset link sent successfully to: $email');
    } catch (e, stackTrace) {
      _logger.error('Failed to send password reset link', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to send reset link. Please try again.',
      );
    }
  }
}

final forgotPasswordControllerProvider = StateNotifierProvider.autoDispose<
    ForgotPasswordController, ForgotPasswordState>((ref) {
  return ForgotPasswordController(
    getIt<RequestPasswordResetUseCase>(),
    getIt<LoggerService>(),
  );
});
