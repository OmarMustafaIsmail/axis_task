import 'package:axis_task/modules/home/data/datasource/remote_celebrity_data_source.dart';
import 'package:axis_task/utils/network/remote/fetch_exception.dart';
import 'package:dartz/dartz.dart';

abstract class BaseCelebrityRepository{
  Future<Either<FetchException,CelebrityModelResponse>> getPopularCelebrities({required int page});

}