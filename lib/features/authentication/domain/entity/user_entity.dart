/// User entity domain model per Clean Architecture standards.
class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String? dateOfBirth;

  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    this.dateOfBirth,
  });
}
