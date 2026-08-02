import '../repository/auth_repository.dart';

/// UseCase to update/reset user password.
class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<void> execute({
    required String email,
    required String newPassword,
  }) async {
    await _repository.resetPassword(email, newPassword);
  }
}
