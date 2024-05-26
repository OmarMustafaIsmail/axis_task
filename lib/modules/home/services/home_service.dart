import 'package:axis_task/modules/home/models/celebrity_model.dart';
import 'package:axis_task/utils/network/remote/dio_manager.dart';
import 'package:axis_task/utils/network/remote/end_points.dart';
import 'package:flutter/material.dart';

class HomeService {
  //get all celebrities paginated from TMDB API
  Future<CelebrityModelResponse> getCelebrities({required int page}) async {
    final result = await DioHelper.getData(
      url: ApiConstants.getCelebrities,
      query: {'page': page},
    );
    List<CelebrityModel> celebrities = [];

    //printing response data for debugging
    debugPrint(result.toString());
    if (result.statusCode == 200) {
      result.data['results'].forEach(
        (celebrity) => celebrities.add(
          CelebrityModel.fromJosn(celebrity),
        ),
      );
    }
    return CelebrityModelResponse(
      celebrities: celebrities,
      canLoadMore: page < result.data['total_pages'],
    );
  }
}

class CelebrityModelResponse {
  final List<CelebrityModel> celebrities;
  final bool canLoadMore;

  CelebrityModelResponse({
    required this.celebrities,
    required this.canLoadMore,
  });
}
