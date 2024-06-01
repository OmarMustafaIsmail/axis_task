import 'package:axis_task/modules/person/domain/entities/celebrity_details.dart';

class CelebrityDetailsModel extends CelebrityDetails {
  const CelebrityDetailsModel({
    required super.id,
    required super.biography,
    required super.birthDate,
    required super.mainImage,
    required super.placeOfBirth,
    required super.name,
    super.celebrityImages
  });

  factory CelebrityDetailsModel.fromJson(Map<String, dynamic> json) =>
      CelebrityDetailsModel(
        id: json['id'] ??0,
        biography: json['biography'] ?? '',
        birthDate: json['birthday'] ?? '',
        mainImage: json['profile_path'] ?? '',
        placeOfBirth: json['place_of_birth'] ?? '',
        name: json['name']??'',
      );

  CelebrityDetailsModel copyWith({
    int? id,
    String? biography,
    String? birthDate,
    String? mainImage,
    String? placeOfBirth,
    String? name,
    List<String>? celebrityImages,
  }) {
    return CelebrityDetailsModel(
      id: id ?? this.id,
      biography: biography ?? this.biography,
      birthDate: birthDate ?? this.birthDate,
      mainImage: mainImage ?? this.mainImage,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      name: name ?? this.name,
      celebrityImages: celebrityImages ?? List.from(this.celebrityImages ?? []),
    );
  }
}
