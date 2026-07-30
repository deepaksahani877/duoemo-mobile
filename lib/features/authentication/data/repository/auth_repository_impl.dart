import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_local_datasource.dart';

/// Implementation of AuthRepository bridging data sources and domain use cases.
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._localDataSource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final dto = await _localDataSource.login(email, password);
    return dto.toEntity();
  }

  @override
  Future<UserEntity> register({
    required String fullName,
    required String email,
    required String password,
    required String dateOfBirth,
  }) async {
    final dto = await _localDataSource.register(
      fullName,
      email,
      password,
      dateOfBirth,
    );
    return dto.toEntity();
  }
}
