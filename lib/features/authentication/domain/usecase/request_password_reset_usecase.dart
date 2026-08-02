import '../repository/auth_repository.dart';

/// UseCase to request a password reset link/code for registered email.
class RequestPasswordResetUseCase {
  final AuthRepository _repository;

  RequestPasswordResetUseCase(this._repository);

  Future<void> execute(String email) async {
    await _repository.requestPasswordReset(email);
  }
}
