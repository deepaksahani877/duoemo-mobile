import '../repository/auth_repository.dart';

/// UseCase to verify the 6-digit OTP code.
class VerifyOtpUseCase {
  final AuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  Future<bool> execute({
    required String email,
    required String otp,
  }) async {
    return await _repository.verifyOtp(email, otp);
  }
}
