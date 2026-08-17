import '../../domain/entity/memory_item_entity.dart';

/// Data transfer object mapping memory media records to domain entities.
class MemoryItemDto {
  final String id;
  final String assetPath;
  final String duration;
  final String category;
  final bool isVideo;

  const MemoryItemDto({
    required this.id,
    required this.assetPath,
    required this.duration,
    required this.category,
    this.isVideo = true,
  });

  MemoryItemEntity toEntity() {
    MemoryCategory cat;
    switch (category.toLowerCase()) {
      case 'photos':
        cat = MemoryCategory.photos;
        break;
      case 'videos':
        cat = MemoryCategory.videos;
        break;
      case 'audio':
        cat = MemoryCategory.audio;
        break;
      default:
        cat = MemoryCategory.all;
    }

    return MemoryItemEntity(
      id: id,
      assetPath: assetPath,
      duration: duration,
      category: cat,
      isVideo: isVideo,
    );
  }
}
