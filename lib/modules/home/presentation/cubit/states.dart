import 'package:axis_task/modules/home/domain/entities/celebrity.dart';

abstract class HomeScreenStates {}

class HomeScreenDataState extends HomeScreenStates {
  final List<Celebrity> celebrities;
  bool hasMorePages;
  HomeScreenDataState({
    this.celebrities = const [],
    this.hasMorePages = false,
  });
}

class HomeScreenLoadingDataState extends HomeScreenStates {
  final List<Celebrity> oldCelebrities;
  final bool isFirstFetch;

  HomeScreenLoadingDataState(
    this.oldCelebrities, {
    this.isFirstFetch = false,
  });
}
