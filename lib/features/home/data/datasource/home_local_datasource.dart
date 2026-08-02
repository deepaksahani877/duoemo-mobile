import '../model/home_data_dto.dart';

abstract class HomeLocalDataSource {
  Future<HomeDataDto> getHomeData();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<HomeDataDto> getHomeData() async {
    return const HomeDataDto(
      userName: 'Suraj ✨',
      partnerName: 'Neha',
      isConnected: true,
      streakDays: 23,
      memoryQuote:
          'Every little moment with you becomes my favorite memory."',
      unreadMessagesCount: 12,
      unreadVoiceNotesCount: 5,
      totalPhotosCount: 128,
      upcomingEventsCount: 7,
      pendingTasksCount: 3,
    );
  }
}
