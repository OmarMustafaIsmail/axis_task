import 'package:axis_task/modules/home/models/celebrity_model.dart';

abstract class HomeScreenStates {}

class HomeScreenDataState extends HomeScreenStates {
  final List<CelebrityModel> celebrities;
  bool hasMorePages;
  HomeScreenDataState({
    this.celebrities = const [],
    this.hasMorePages = false,
  });
}

class HomeScreenLoadingDataState extends HomeScreenStates {
  final List<CelebrityModel> oldCelebrities;
  final bool isFirstFetch;

  HomeScreenLoadingDataState(
    this.oldCelebrities, {
    this.isFirstFetch = false,
  });
}
