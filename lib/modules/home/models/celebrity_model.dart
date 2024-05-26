class CelebrityModel {
  late final int id;
  late final String name;
  late final String mainImage;
  late final double popularity;
  late final String department;

  CelebrityModel({
    required this.id,
    required this.name,
    required this.mainImage,
    required this.department,
    required this.popularity,
  });

  CelebrityModel.fromJosn(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? 'Default name';
    mainImage = json['profile_path'] ?? '';
    popularity = json['popularity'] ?? 0.0;
    department = json['known_for_department'] ?? 'Default Department';
  }
}
