import '../../domain/entity/memory_item_entity.dart';
import '../../domain/repository/memories_repository.dart';
import '../datasource/memories_local_datasource.dart';

/// Bridges memories data sources with domain logic.
class MemoriesRepositoryImpl implements MemoriesRepository {
  final MemoriesLocalDataSource _dataSource;

  MemoriesRepositoryImpl(this._dataSource);

  @override
  Future<List<MemoryItemEntity>> getMemories({
    MemoryCategory category = MemoryCategory.all,
  }) async {
    final dtos = await _dataSource.getMemories();
    final entities = dtos.map((dto) => dto.toEntity()).toList();

    if (category == MemoryCategory.all) {
      return entities;
    }
    return entities.where((item) => item.category == category).toList();
  }
}
