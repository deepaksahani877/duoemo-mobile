import '../../domain/repository/welcome_repository.dart';
import '../datasource/welcome_local_datasource.dart';

/// Implementation of WelcomeRepository interfacing with local data sources.
class WelcomeRepositoryImpl implements WelcomeRepository {
  final WelcomeLocalDataSource _dataSource;

  WelcomeRepositoryImpl(this._dataSource);

  @override
  Future<bool> isFirstTimeUser() async {
    return await _dataSource.getIsFirstTime();
  }

  @override
  Future<void> setWelcomeSeen() async {
    await _dataSource.setIsFirstTime(false);
  }
}
