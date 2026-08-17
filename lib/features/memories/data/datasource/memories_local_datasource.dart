import '../../../../app/constants/app_assets.dart';
import '../model/memory_item_dto.dart';

abstract class MemoriesLocalDataSource {
  Future<List<MemoryItemDto>> getMemories();
}

class MemoriesLocalDataSourceImpl implements MemoriesLocalDataSource {
  final List<MemoryItemDto> _items = const [
    MemoryItemDto(
      id: 'mem_1',
      assetPath: AppAssets.memory1,
      duration: '0:31',
      category: 'videos',
      isVideo: true,
    ),
    MemoryItemDto(
      id: 'mem_2',
      assetPath: AppAssets.memory2,
      duration: '0:24',
      category: 'videos',
      isVideo: true,
    ),
    MemoryItemDto(
      id: 'mem_3',
      assetPath: AppAssets.memory3,
      duration: '0:15',
      category: 'videos',
      isVideo: true,
    ),
    MemoryItemDto(
      id: 'mem_4',
      assetPath: AppAssets.memory4,
      duration: '0:31',
      category: 'photos',
      isVideo: false,
    ),
    MemoryItemDto(
      id: 'mem_5',
      assetPath: AppAssets.memory2,
      duration: '0:18',
      category: 'videos',
      isVideo: true,
    ),
    MemoryItemDto(
      id: 'mem_6',
      assetPath: AppAssets.memory3,
      duration: '0:31',
      category: 'photos',
      isVideo: false,
    ),
    MemoryItemDto(
      id: 'mem_7',
      assetPath: AppAssets.memory1,
      duration: '0:22',
      category: 'videos',
      isVideo: true,
    ),
    MemoryItemDto(
      id: 'mem_8',
      assetPath: AppAssets.memory2,
      duration: '0:35',
      category: 'videos',
      isVideo: true,
    ),
    MemoryItemDto(
      id: 'mem_9',
      assetPath: AppAssets.memory4,
      duration: '0:28',
      category: 'audio',
      isVideo: true,
    ),
  ];

  @override
  Future<List<MemoryItemDto>> getMemories() async {
    return List.from(_items);
  }
}
