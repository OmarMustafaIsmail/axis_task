import 'package:axis_task/modules/home/data/datasource/remote_celebrity_data_source.dart';
import 'package:axis_task/modules/home/domain/repository/base_celebrity_repository.dart';
import 'package:axis_task/utils/network/remote/fetch_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class CelebrityRepository extends BaseCelebrityRepository{
  final BaseRemoteCelebrityDataSource baseRemoteDataSource;

  CelebrityRepository(this.baseRemoteDataSource);
  @override
  Future<Either<FetchException, CelebrityModelResponse>> getPopularCelebrities({required int page}) async {
    try {
      final result = await baseRemoteDataSource.getPopularCelebrities(page: page);
      return Right(result);
    } on FetchException catch (failure) {
      debugPrint("Error getting data: ${failure.message}");
      return Left(FetchException(failure.message));
    } catch (error) {
      // Handle any other exceptions
      debugPrint("Unexpected error: $error");
      return const Left(FetchException('An unexpected error occurred!'));
    }
  }
}