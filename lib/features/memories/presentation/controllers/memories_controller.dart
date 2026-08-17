import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/di/injection.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/entity/memory_item_entity.dart';
import '../../domain/usecase/get_memories_usecase.dart';

class MemoriesState {
  final bool isLoading;
  final List<MemoryItemEntity> items;
  final MemoryCategory selectedCategory;
  final String? errorMessage;

  const MemoriesState({
    this.isLoading = false,
    this.items = const [],
    this.selectedCategory = MemoryCategory.all,
    this.errorMessage,
  });

  MemoriesState copyWith({
    bool? isLoading,
    List<MemoryItemEntity>? items,
    MemoryCategory? selectedCategory,
    String? errorMessage,
  }) {
    return MemoriesState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class MemoriesController extends StateNotifier<MemoriesState> {
  final GetMemoriesUseCase _getMemoriesUseCase;
  final LoggerService _logger;

  MemoriesController(this._getMemoriesUseCase, this._logger)
      : super(const MemoriesState()) {
    loadMemories();
  }

  Future<void> loadMemories({MemoryCategory category = MemoryCategory.all}) async {
    _logger.info('Fetching memories for category: $category');
    state = state.copyWith(isLoading: true, errorMessage: null, selectedCategory: category);

    try {
      final list = await _getMemoriesUseCase.execute(category: category);
      state = state.copyWith(isLoading: false, items: list);
      _logger.info('Retrieved ${list.length} memory items');
    } catch (e, stackTrace) {
      _logger.error('Failed to load memories', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unable to load memories.',
      );
    }
  }

  void filterCategory(MemoryCategory category) {
    if (state.selectedCategory == category) return;
    loadMemories(category: category);
  }
}

final memoriesControllerProvider =
    StateNotifierProvider.autoDispose<MemoriesController, MemoriesState>((ref) {
  return MemoriesController(
    getIt<GetMemoriesUseCase>(),
    getIt<LoggerService>(),
  );
});
