import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/di/injection.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/usecase/reset_password_usecase.dart';

class CreateNewPasswordState {
  final bool isLoading;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String newPassword;
  final String confirmPassword;
  final String? errorMessage;
  final bool isSuccess;

  const CreateNewPasswordState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.newPassword = '',
    this.confirmPassword = '',
    this.errorMessage,
    this.isSuccess = false,
  });

  CreateNewPasswordState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? newPassword,
    String? confirmPassword,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return CreateNewPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  // Password rules validation
  bool get hasAtLeast8Chars => newPassword.length >= 8;
  bool get hasUpperAndLower =>
      newPassword.contains(RegExp(r'[A-Z]')) &&
      newPassword.contains(RegExp(r'[a-z]'));
  bool get hasNumberOrSpecialChar =>
      newPassword.contains(RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]'));

  bool get isPasswordStrong =>
      hasAtLeast8Chars && hasUpperAndLower && hasNumberOrSpecialChar;
}

class CreateNewPasswordController
    extends StateNotifier<CreateNewPasswordState> {
  final ResetPasswordUseCase _useCase;
  final LoggerService _logger;

  CreateNewPasswordController(this._useCase, this._logger)
      : super(const CreateNewPasswordState());

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(newPassword: password, errorMessage: null);
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      errorMessage: null,
    );
  }

  Future<void> resetPassword(String email) async {
    _logger.info('Resetting password for email: $email');
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _useCase.execute(
        email: email,
        newPassword: state.newPassword,
      );
      state = state.copyWith(isLoading: false, isSuccess: true);
      _logger.info('Password reset successfully');
    } catch (e, stackTrace) {
      _logger.error('Failed to reset password', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to reset password. Please try again.',
      );
    }
  }
}

final createNewPasswordControllerProvider = StateNotifierProvider.autoDispose<
    CreateNewPasswordController, CreateNewPasswordState>((ref) {
  return CreateNewPasswordController(
    getIt<ResetPasswordUseCase>(),
    getIt<LoggerService>(),
  );
});
