/// Local data source contract and implementation for Welcome feature.
abstract class WelcomeLocalDataSource {
  Future<bool> getIsFirstTime();
  Future<void> setIsFirstTime(bool value);
}

class WelcomeLocalDataSourceImpl implements WelcomeLocalDataSource {
  bool _isFirstTime = true;

  @override
  Future<bool> getIsFirstTime() async {
    return _isFirstTime;
  }

  @override
  Future<void> setIsFirstTime(bool value) async {
    _isFirstTime = value;
  }
}
