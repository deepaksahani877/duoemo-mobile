import '../../domain/entity/user_entity.dart';

/// User DTO model mapping between Data layer and Domain Entity.
class UserDto {
  final String id;
  final String email;
  final String fullName;
  final String? dateOfBirth;

  const UserDto({
    required this.id,
    required this.email,
    required this.fullName,
    this.dateOfBirth,
  });

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      fullName: fullName,
      dateOfBirth: dateOfBirth,
    );
  }
}
