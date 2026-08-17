import '../entity/memory_item_entity.dart';

/// Repository interface for retrieving and managing shared memories.
abstract class MemoriesRepository {
  Future<List<MemoryItemEntity>> getMemories({MemoryCategory category = MemoryCategory.all});
}
