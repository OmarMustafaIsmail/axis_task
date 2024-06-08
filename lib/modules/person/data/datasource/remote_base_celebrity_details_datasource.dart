import 'package:axis_task/modules/person/data/models/celebrity_details_model.dart';
import 'package:axis_task/utils/network/remote/dio_manager.dart';
import 'package:axis_task/utils/network/remote/end_points.dart';
import 'package:axis_task/utils/network/remote/fetch_exception.dart';
import 'package:flutter/material.dart';

abstract class BaseRemoteCelebrityDetailsDataSource{
  Future<CelebrityDetailsModel> getCelebrityDetails({required int id});
}

class RemoteCelebrityDetailsDataSource extends BaseRemoteCelebrityDetailsDataSource{
  @override
  Future<CelebrityDetailsModel> getCelebrityDetails({required int id}) async{

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
    }else{
      throw FetchException(result.data['status_message']);
    }
    if (images.statusCode == 200) {
      List<String> imagePaths = [];
      images.data['profiles'].forEach((image) {
        imagePaths.add(image['file_path']);
      });
      celebrityDetails = celebrityDetails.copyWith(celebrityImages: imagePaths);
    } else {
      throw FetchException("error getting images ${result.data['status_message']}");
    }
    //print final celebrity model
    debugPrint("celebrity details =>${celebrityDetails.toString()}");
    return celebrityDetails;
  }

}