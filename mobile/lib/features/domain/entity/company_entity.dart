class CompanyEntity {
  final String id;
  final String name;
  final String profile;
  final String cover;
  final String description;
  final String problem;
  final bool verified;

  const CompanyEntity({
    required this.id,
    required this.name,
    required this.profile,
    required this.cover,
    required this.description,
    required this.problem,
    required this.verified,
  });
}
