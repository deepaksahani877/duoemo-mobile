import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/di/injection.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/usecase/get_welcome_config.dart';

class WelcomeState {
  final bool isLoading;
  final bool isFirstTime;
  final String? errorMessage;

  const WelcomeState({
    this.isLoading = false,
    this.isFirstTime = true,
    this.errorMessage,
  });

  WelcomeState copyWith({
    bool? isLoading,
    bool? isFirstTime,
    String? errorMessage,
  }) {
    return WelcomeState(
      isLoading: isLoading ?? this.isLoading,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class WelcomeController extends StateNotifier<WelcomeState> {
  final GetWelcomeConfigUseCase _getWelcomeConfigUseCase;
  final LoggerService _logger;

  WelcomeController(this._getWelcomeConfigUseCase, this._logger)
      : super(const WelcomeState()) {
    _init();
  }

  Future<void> _init() async {
    final isFirstTime = await _getWelcomeConfigUseCase.execute();
    state = state.copyWith(isFirstTime: isFirstTime);
  }

  Future<void> handleCreateDuo() async {
    _logger.info('User tapped Create Your Duo');
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(isLoading: false);
  }

  Future<void> handleAlreadyHaveAccount() async {
    _logger.info('User tapped I already have an account');
  }
}

final welcomeControllerProvider =
    StateNotifierProvider<WelcomeController, WelcomeState>((ref) {
  return WelcomeController(
    getIt<GetWelcomeConfigUseCase>(),
    getIt<LoggerService>(),
  );
});
