import 'package:axis_task/modules/person/data/datasource/remote_base_celebrity_details_datasource.dart';
import 'package:axis_task/modules/person/data/repository/celebrity_details_repository.dart';
import 'package:axis_task/modules/person/domain/entities/celebrity_details.dart';
import 'package:axis_task/modules/person/domain/repository/base_celebrity_details_repositoy.dart';
import 'package:axis_task/modules/person/domain/usecases/get_celebrity_details_usecase.dart';
import 'package:axis_task/shared/globs.dart';
import 'package:axis_task/utils/network/remote/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import 'states.dart';

class CelebrityDetailsCubit extends Cubit<CelebrityDetailsStates> {
  CelebrityDetailsCubit()
      : super(
          CelebrityDetailsDataState(
            celebrityDetails: const CelebrityDetails(
                id: 0,
                biography: '',
                birthDate: '',
                mainImage: '',
                placeOfBirth: '',
                name: ''),
          ),
        );


  //function to get a specific celebrity data
  Future<void> getCelebrityDetails({required int id}) async {
    if ((state as CelebrityDetailsDataState).celebrityDetails != null) {
      (state as CelebrityDetailsDataState).celebrityDetails =
          const CelebrityDetails(
        id: -1,
        biography: '',
        birthDate: '',
        mainImage: '',
        placeOfBirth: '',
        name: '',
      );
    }
    BaseRemoteCelebrityDetailsDataSource baseRemoteCelebrityDetailsDataSource = RemoteCelebrityDetailsDataSource();
    BaseCelebrityDetailsRepository baseCelebrityDetailsRepository = CelebrityDetailsRepository(baseRemoteCelebrityDetailsDataSource);
    var result = await GetCelebrityDetailsUseCase(baseCelebrityDetailsRepository).execute(id: id);
    result.fold((l)  {
      Globals.snackBarKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(l.message),
        ),
      );
    }, (r) {
      emit(CelebrityDetailsDataState(celebrityDetails: r));
    });

  }

  //save image to device
  Future<dynamic> saveImageToDevice(
      {required String imagePath, required String celebrityName}) async {
    //ask for permission to access gallery first
    final PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      //get image path as bytes
      debugPrint(imagePath);
      try {
        var response = await Dio().get(
            "${ApiConstants.baseImageUrl}/$imagePath",
            options: Options(responseType: ResponseType.bytes));

        //save image to gallery with ImageGallerySaver package
        try {
          await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
            name: celebrityName,
          );
          Globals.snackBarKey.currentState?.showSnackBar(
            const SnackBar(
              content:  Text('Image saved successfully!!'),
            ),
          );
          return true;
        } catch (e) {
          Globals.snackBarKey.currentState?.showSnackBar(
            const SnackBar(
              content:  Text('Error saving image'),
            ),
          );
          return false;
        }
      } catch (error) {
        Globals.snackBarKey.currentState?.showSnackBar(
          const SnackBar(
            content:  Text('Error fetching image'),
          ),
        );
        return false;
      }
    } else {
      Globals.snackBarKey.currentState?.showSnackBar(
        const SnackBar(
          content:  Text('Enable access to gallery first'),
        ),
      );
      return false;
    }
  }
}
