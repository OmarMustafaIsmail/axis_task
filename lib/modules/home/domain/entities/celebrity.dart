import 'package:equatable/equatable.dart';

class Celebrity extends Equatable{
   final int id;
   final String name;
   final String mainImage;
   final double popularity;
   final String department;

  const Celebrity({
    required this.id,
    required this.name,
    required this.mainImage,
    required this.department,
    required this.popularity,
  });

   @override
  List<Object> get props =>[id,name,mainImage,popularity,department,];


}