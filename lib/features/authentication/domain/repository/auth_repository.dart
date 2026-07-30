import '../entity/user_entity.dart';

/// Authentication repository contract per Clean Architecture.
abstract class AuthRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> register({
    required String fullName,
    required String email,
    required String password,
    required String dateOfBirth,
  });
}
