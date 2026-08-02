import '../entity/home_data_entity.dart';
import '../repository/home_repository.dart';

/// UseCase to fetch Home dashboard data.
class GetHomeDataUseCase {
  final HomeRepository _repository;

  GetHomeDataUseCase(this._repository);

  Future<HomeDataEntity> execute() async {
    return await _repository.getHomeData();
  }
}
