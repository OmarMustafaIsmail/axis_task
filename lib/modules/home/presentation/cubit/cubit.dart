import 'package:axis_task/modules/home/data/datasource/remote_celebrity_data_source.dart';
import 'package:axis_task/modules/home/data/repositories/celebrity_repository.dart';
import 'package:axis_task/modules/home/domain/entities/celebrity.dart';
import 'package:axis_task/modules/home/domain/repository/base_celebrity_repository.dart';
import 'package:axis_task/modules/home/domain/usecases/get_popular_celebrities_usecase.dart';
import 'package:axis_task/modules/home/presentation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit()
      : super(
          HomeScreenDataState(hasMorePages: false),
        );

  //Function that gets celebrities paginated
  int page = 1;
  Future<void> getCelebrities() async {
    if (state is HomeScreenLoadingDataState) return;
    final currentState = state;
    var oldCelebrities = <Celebrity>[];

    if (currentState is HomeScreenDataState) {
      oldCelebrities = currentState.celebrities;
    }
    emit(HomeScreenLoadingDataState(oldCelebrities, isFirstFetch: page == 1));
    BaseRemoteDataSource baseRemoteDataSource = RemoteCelebrityDataSource();
    BaseCelebrityRepository baseCelebrityRepository = CelebrityRepository(baseRemoteDataSource);
    var newCelebrities = await GetPopularCelebritiesUseCase(baseCelebrityRepository).execute(page: page);
    page++;
    var celebrities = List<Celebrity>.from(
        (state as HomeScreenLoadingDataState).oldCelebrities,);
    bool canLoadMore = false;
    newCelebrities.fold((l) {
      debugPrint(l.message);
    }, (r) {
      celebrities.addAll(r.celebrities);
      canLoadMore = r.canLoadMore;
    });
    emit(
      HomeScreenDataState(
          celebrities: celebrities, hasMorePages: canLoadMore),
    );
  }
}
