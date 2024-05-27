import 'package:axis_task/modules/person/models/celebrity_details_mode.dart';
import 'package:axis_task/utils/network/remote/dio_manager.dart';
import 'package:axis_task/utils/network/remote/end_points.dart';
import 'package:flutter/material.dart';

class CelebrityDetailsService {
  //get celebrity details data frorm TMBD API
  Future<CelebrityDetailsModel> getCelebrityDetails({required int id}) async {
    final result =
        await DioHelper.getData(url: '${ApiConstants.getCelebrityDetails}/$id');
    final images = await DioHelper.getData(
        url: '${ApiConstants.getCelebrityDetails}/$id/images');

    CelebrityDetailsModel celebrityDetails = CelebrityDetailsModel(
      id: id,
      biography: 'biography',
      birthDate: 'birthDate',
      mainImage: 'mainImage',
      placeOfBirth: 'placeOfBirth',
      name: 'name',
    );
    if (result.statusCode == 200) {
      celebrityDetails = CelebrityDetailsModel.fromJson(result.data);
    }
    if (images.statusCode == 200) {
      images.data['profiles'].forEach(
        (image) => celebrityDetails.celebrityImages!.add(
          image['file_path'],
        ),
      );
    }
    //print final celebrity model
    debugPrint("celebrity details =>${celebrityDetails.toString()}");
    return celebrityDetails;
  }
}
