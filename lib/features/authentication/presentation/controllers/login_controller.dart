import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/di/injection.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/usecase/login_usecase.dart';

class LoginState {
  final bool isLoading;
  final bool isPasswordVisible;
  final String? errorMessage;
  final bool isSuccess;

  const LoginState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class LoginController extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;
  final LoggerService _logger;

  LoginController(this._loginUseCase, this._logger)
      : super(const LoginState());

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  Future<void> login(String email, String password) async {
    _logger.info('Attempting login for email: $email');
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _loginUseCase.execute(email: email, password: password);
      state = state.copyWith(isLoading: false, isSuccess: true);
      _logger.info('Login successful for email: $email');
    } catch (e, stackTrace) {
      _logger.error('Login failed', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Login failed. Please check your credentials.',
      );
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginState>((ref) {
  return LoginController(
    getIt<LoginUseCase>(),
    getIt<LoggerService>(),
  );
});
