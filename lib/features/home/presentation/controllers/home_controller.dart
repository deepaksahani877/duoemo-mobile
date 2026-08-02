import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/di/injection.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/entity/home_data_entity.dart';
import '../../domain/usecase/get_home_data_usecase.dart';

class HomeState {
  final bool isLoading;
  final HomeDataEntity? homeData;
  final int selectedNavIndex;
  final String? errorMessage;

  const HomeState({
    this.isLoading = false,
    this.homeData,
    this.selectedNavIndex = 0,
    this.errorMessage,
  });

  HomeState copyWith({
    bool? isLoading,
    HomeDataEntity? homeData,
    int? selectedNavIndex,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      homeData: homeData ?? this.homeData,
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class HomeController extends StateNotifier<HomeState> {
  final GetHomeDataUseCase _getHomeDataUseCase;
  final LoggerService _logger;

  HomeController(this._getHomeDataUseCase, this._logger)
      : super(const HomeState()) {
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    _logger.info('Loading Home dashboard data');
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final data = await _getHomeDataUseCase.execute();
      state = state.copyWith(isLoading: false, homeData: data);
      _logger.info('Home dashboard data loaded successfully');
    } catch (e, stackTrace) {
      _logger.error('Failed to load Home data', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load Home data.',
      );
    }
  }

  void selectNavTab(int index) {
    state = state.copyWith(selectedNavIndex: index);
    _logger.info('Selected navigation tab index: $index');
  }
}

final homeControllerProvider =
    StateNotifierProvider.autoDispose<HomeController, HomeState>((ref) {
  return HomeController(
    getIt<GetHomeDataUseCase>(),
    getIt<LoggerService>(),
  );
});
