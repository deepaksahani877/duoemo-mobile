/// Repository contract for the Welcome feature per Clean Architecture rules.
abstract class WelcomeRepository {
  Future<bool> isFirstTimeUser();
  Future<void> setWelcomeSeen();
}
