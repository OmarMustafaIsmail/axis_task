import 'package:equatable/equatable.dart';

class CelebrityDetails extends Equatable{
   final int id;
   final String birthDate;
   final String name;
   final String biography;
   final String placeOfBirth;
   final String mainImage;
   final List<String>? celebrityImages;

  const CelebrityDetails({
    required this.id,
    required this.biography,
    required this.birthDate,
    required this.mainImage,
    required this.placeOfBirth,
    required this.name,
    this.celebrityImages = const [],
  });

  @override
  List<Object?> get props => [id,birthDate,name,biography,placeOfBirth,mainImage,celebrityImages];
}