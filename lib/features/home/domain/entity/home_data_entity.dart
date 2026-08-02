/// Home data entity per Clean Architecture rules.
class HomeDataEntity {
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

  const HomeDataEntity({
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
}
