import 'package:axis_task/modules/person/cubit/states.dart';
import 'package:axis_task/modules/person/models/celebrity_details_mode.dart';
import 'package:axis_task/modules/person/services/celebrity_details_service.dart';
import 'package:axis_task/utils/network/remote/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class CelebrityDetailsCubit extends Cubit<CelebrityDetailsStates> {
  CelebrityDetailsCubit()
      : super(
          CelebrityDetailsDataState(
            celebrityDetails: CelebrityDetailsModel(
                id: 0,
                biography: '',
                birthDate: '',
                mainImage: '',
                placeOfBirth: '',
                name: ''),
          ),
        );

  final _celebrityDetailsService = CelebrityDetailsService();

  //function to get a specific celebrity data
  Future<void> getCelebrityDetails({required int id}) async {
    if ((state as CelebrityDetailsDataState).celebrityDetails != null) {
      (state as CelebrityDetailsDataState).celebrityDetails =
          CelebrityDetailsModel(
        id: -1,
        biography: '',
        birthDate: '',
        mainImage: '',
        placeOfBirth: '',
        name: '',
      );
    }
    final result = await _celebrityDetailsService.getCelebrityDetails(id: id);
    emit(CelebrityDetailsDataState(celebrityDetails: result));
  }

  //save image to device
  Future<dynamic> saveImageToDevice(
      {required String imagePath, required String celebrityName}) async {
    //ask for permission to acccess gallery first
    final PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      //get image path as bytes
      debugPrint(imagePath);
      try {
        var response = await Dio().get(
            "${ApiConstants.baseImageUrl}/$imagePath",
            options: Options(responseType: ResponseType.bytes));

        //save image to gallery with ImageGallerySver package
        try {
          await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
            name: celebrityName,
          );
          return true;
        } catch (e) {
          debugPrint(e.toString());
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      return false;
    }
  }
}
