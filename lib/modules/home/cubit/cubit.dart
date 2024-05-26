import 'package:axis_task/modules/home/cubit/states.dart';
import 'package:axis_task/modules/home/models/celebrity_model.dart';
import 'package:axis_task/modules/home/services/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit()
      : super(
          HomeScreenDataState(hasMorePages: false),
        );

  final _homeService = HomeService();

  //Function that gets celebrities paginated
  int page = 1;
  Future<void> getCelebrities() async {
    if (state is HomeScreenLoadingDataState) return;
    final currentState = state;
    var oldCelebrities = <CelebrityModel>[];

    if (currentState is HomeScreenDataState) {
      oldCelebrities = currentState.celebrities;
    }
    emit(HomeScreenLoadingDataState(oldCelebrities, isFirstFetch: page == 1));

    var newCelebrities = await _homeService.getCelebrities(page: page);
    page++;
    var celebrities = List<CelebrityModel>.from(
        (state as HomeScreenLoadingDataState).oldCelebrities);
    celebrities.addAll(newCelebrities.celebrities);
    emit(
      HomeScreenDataState(
          celebrities: celebrities, hasMorePages: newCelebrities.canLoadMore),
    );
  }
}
