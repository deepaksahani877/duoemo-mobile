import '../entity/memory_item_entity.dart';
import '../repository/memories_repository.dart';

/// Fetches media memory items filtered by category.
class GetMemoriesUseCase {
  final MemoriesRepository _repository;

  GetMemoriesUseCase(this._repository);

  Future<List<MemoryItemEntity>> execute({
    MemoryCategory category = MemoryCategory.all,
  }) async {
    return await _repository.getMemories(category: category);
  }
}
