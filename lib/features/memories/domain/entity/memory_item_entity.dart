enum MemoryCategory { all, photos, videos, audio }

/// Represents a media item in the user's shared memories gallery.
class MemoryItemEntity {
  final String id;
  final String assetPath;
  final String duration;
  final MemoryCategory category;
  final bool isVideo;

  const MemoryItemEntity({
    required this.id,
    required this.assetPath,
    required this.duration,
    required this.category,
    this.isVideo = true,
  });
}
