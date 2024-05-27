import 'dart:convert';

import 'package:axis_task/modules/home/models/celebrity_model.dart';
import 'package:axis_task/utils/network/remote/dio_manager.dart';
import 'package:axis_task/utils/network/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  //get all celebrities paginated from TMDB API
  Future<CelebrityModelResponse> getCelebrities({required int page}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<CelebrityModel> celebrities = [];

    try {
      final result = await DioHelper.getData(
        url: ApiConstants.getCelebrities,
        query: {'page': page},
      );

      //printing response data for debugging
      debugPrint(result.toString());
      if (result.statusCode == 200) {
        result.data['results'].forEach(
          (celebrity) => celebrities.add(
            CelebrityModel.fromJosn(celebrity),
          ),
        );

        // Save to local storage
        List<String> jsonCelebrities = celebrities
            .map((celebrity) => jsonEncode(celebrity.toJson()))
            .toList();
        await prefs.setStringList('celebrities_page_$page', jsonCelebrities);
      }
      return CelebrityModelResponse(
        celebrities: celebrities,
        canLoadMore: page < result.data['total_pages'],
      );
    } catch (error) {
      debugPrint("Error => $error. Trying to load from SharedPreferences.");
      final List<String>? localData =
          prefs.getStringList('celebrities_page_$page');
      if (localData != null) {
        debugPrint("Loaded from SharedPreferences: $localData");
        celebrities = localData
            .map((jsonCelebrity) => CelebrityModel.fromJosn(
                  jsonDecode(jsonCelebrity),
                ))
            .toList();

        return CelebrityModelResponse(
          celebrities: celebrities,
          canLoadMore: false,
        );
      } else {
        rethrow; // If there's no local data, rethrow the error
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
