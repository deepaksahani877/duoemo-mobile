import '../../domain/entity/home_data_entity.dart';

/// Home data DTO mapping to domain entity.
class HomeDataDto {
  final String userName;
  final String partnerName;
  final bool isConnected;
  final int streakDays;
  final String memoryQuote;
  final int unreadMessagesCount;
  final int unreadVoiceNotesCount;
  final int totalPhotosCount;
  final int upcomingEventsCount;
  final int pendingTasksCount;

  const HomeDataDto({
    required this.userName,
    required this.partnerName,
    required this.isConnected,
    required this.streakDays,
    required this.memoryQuote,
    required this.unreadMessagesCount,
    required this.unreadVoiceNotesCount,
    required this.totalPhotosCount,
    required this.upcomingEventsCount,
    required this.pendingTasksCount,
  });

  HomeDataEntity toEntity() {
    return HomeDataEntity(
      userName: userName,
      partnerName: partnerName,
      isConnected: isConnected,
      streakDays: streakDays,
      memoryQuote: memoryQuote,
      unreadMessagesCount: unreadMessagesCount,
      unreadVoiceNotesCount: unreadVoiceNotesCount,
      totalPhotosCount: totalPhotosCount,
      upcomingEventsCount: upcomingEventsCount,
      pendingTasksCount: pendingTasksCount,
    );
  }
}
