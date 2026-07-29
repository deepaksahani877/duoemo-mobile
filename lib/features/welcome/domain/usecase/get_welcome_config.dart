import '../repository/welcome_repository.dart';

/// UseCase to verify initial welcome screen state.
class GetWelcomeConfigUseCase {
  final WelcomeRepository _repository;

  GetWelcomeConfigUseCase(this._repository);

  Future<bool> execute() async {
    return await _repository.isFirstTimeUser();
  }
}
