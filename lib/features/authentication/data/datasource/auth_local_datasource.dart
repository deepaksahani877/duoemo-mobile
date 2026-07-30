import '../model/user_dto.dart';

/// Data source contract and implementation for authentication.
abstract class AuthLocalDataSource {
  Future<UserDto> login(String email, String password);
  Future<UserDto> register(
    String fullName,
    String email,
    String password,
    String dateOfBirth,
  );
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<UserDto> login(String email, String password) async {
    return UserDto(
      id: 'usr_1001',
      email: email,
      fullName: 'Duoemo Partner',
    );
  }

  @override
  Future<UserDto> register(
    String fullName,
    String email,
    String password,
    String dateOfBirth,
  ) async {
    return UserDto(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      fullName: fullName,
      dateOfBirth: dateOfBirth,
    );
  }
}
