import '../entity/home_data_entity.dart';

/// Home repository contract per Clean Architecture.
abstract class HomeRepository {
  Future<HomeDataEntity> getHomeData();
}
