// ignore_for_file: non_constant_identifier_names

class UserEntity {
  final String id;
  final String username;
  final String name;
  final int stars;
  final String class_id;
  final String access_token;

  const UserEntity({
    required this.id,
    required this.username,
    required this.name,
    required this.stars,
    required this.class_id,
    required this.access_token,
  });

  factory UserEntity.emptyUser() => const UserEntity(
        id: '',
        username: '',
        name: '',
        stars: 0,
        class_id: '',
        access_token: '',
      );
}
