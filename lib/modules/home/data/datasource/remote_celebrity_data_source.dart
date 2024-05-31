import 'dart:convert';
import 'package:axis_task/modules/home/data/models/celebrity_model.dart';
import 'package:axis_task/utils/network/local/cache_manager.dart';
import 'package:axis_task/utils/network/remote/fetch_exception.dart';
import 'package:flutter/material.dart';
import '../../../../utils/network/remote/dio_manager.dart';
import '../../../../utils/network/remote/end_points.dart';


abstract class BaseRemoteDataSource{
  Future<CelebrityModelResponse> getPopularCelebrities({required int page});
}

class RemoteCelebrityDataSource extends BaseRemoteDataSource{


  @override
  Future<CelebrityModelResponse> getPopularCelebrities(
      {required int page}) async {
    //get all celebrities paginated from TMDB API
    List<CelebrityModel> celebrities = [];

    final result = await DioHelper.getData(
      url: ApiConstants.getCelebrities,
      query: {'page': page},
    );

    //printing response data for debugging
    debugPrint(result.toString());
    if (result.statusCode == 200) {
      result.data['results'].forEach(
        (celebrity) => celebrities.add(
          CelebrityModel.fromJson(celebrity),
        ),
      );
      // Save to local storage
      List<String> jsonCelebrities = celebrities
          .map((celebrity) => jsonEncode(celebrity.toJson()))
          .toList();
      await CacheManager.saveData(key:'celebrities_page_$page', value:jsonCelebrities);
      return CelebrityModelResponse(
        celebrities: celebrities,
        canLoadMore: page < result.data['total_pages'],
      );
    } else {
      final List<dynamic>? localData =
          CacheManager.getData(key: 'celebrities_page_$page');
      if (localData != null) {
        debugPrint("Loaded from SharedPreferences: $localData");
        celebrities = localData
            .map((jsonCelebrity) => CelebrityModel.fromJson(
                  jsonDecode(jsonCelebrity),
                ))
            .toList();
        return CelebrityModelResponse(
          celebrities: celebrities,
          canLoadMore: false,
        );
      }else {
        debugPrint(result.data);
        throw FetchException(result.data['status_message']);
      }
    }
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
