import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

/// Register use case domain logic.
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<UserEntity> execute({
    required String fullName,
    required String email,
    required String password,
    required String dateOfBirth,
  }) async {
    return await _repository.register(
      fullName: fullName,
      email: email,
      password: password,
      dateOfBirth: dateOfBirth,
    );
  }
}
