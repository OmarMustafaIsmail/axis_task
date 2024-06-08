import 'package:axis_task/modules/home/domain/entities/celebrity.dart';

class CelebrityModel extends Celebrity {
  const CelebrityModel(
      {required super.id,
      required super.name,
      required super.mainImage,
      required super.department,
      required super.popularity});

  factory CelebrityModel.fromJson(Map<String, dynamic> json) => CelebrityModel(
      id: json['id'],
      name: json['name'] ?? 'Default name',
      mainImage: json['profile_path'] ?? '',
      department: json['known_for_department'] ?? 'Default Department',
      popularity: json['popularity'] ?? 0.0,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_path': mainImage,
      'popularity': popularity,
      'known_for_department': department,
    };
  }
}
