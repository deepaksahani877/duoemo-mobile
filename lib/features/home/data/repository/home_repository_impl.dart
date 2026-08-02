import '../../domain/entity/home_data_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../datasource/home_local_datasource.dart';

/// Implementation of HomeRepository bridging data sources and domain use cases.
class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource _dataSource;

  HomeRepositoryImpl(this._dataSource);

  @override
  Future<HomeDataEntity> getHomeData() async {
    final dto = await _dataSource.getHomeData();
    return dto.toEntity();
  }
}
