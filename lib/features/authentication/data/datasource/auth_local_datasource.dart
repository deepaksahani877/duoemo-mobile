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
  Future<void> requestPasswordReset(String email);
  Future<bool> verifyOtp(String email, String otp);
  Future<void> resetPassword(String email, String newPassword);
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

  @override
  Future<void> requestPasswordReset(String email) async {
    // Dummy request password reset call
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<bool> verifyOtp(String email, String otp) async {
    // Dummy OTP verification check
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  @override
  Future<void> resetPassword(String email, String newPassword) async {
    // Dummy reset password call
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
