class CelebrityDetailsModel {
  late final int id;
  late final String birthDate;
  late final String name;
  late final String biography;
  late final String placeOfBirth;
  late final String mainImage;
  List<String>? celebrityImages;

  CelebrityDetailsModel({
    required this.id,
    required this.biography,
    required this.birthDate,
    required this.mainImage,
    required this.placeOfBirth,
    required this.name,
    this.celebrityImages = const [],
  });

  CelebrityDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? 'Default name';
    biography = json['biography'] ?? 'Default Biography';
    birthDate = json['birthday'] ?? '${DateTime.now()}';
    placeOfBirth = json['place_of_birth'] ?? 'Egypt';
    mainImage = json['profile_path'] ?? "";
    celebrityImages = [];
  }
}
