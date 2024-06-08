import 'package:axis_task/modules/person/data/datasource/remote_base_celebrity_details_datasource.dart';
import 'package:axis_task/modules/person/domain/entities/celebrity_details.dart';
import 'package:axis_task/modules/person/domain/repository/base_celebrity_details_repositoy.dart';
import 'package:axis_task/utils/network/remote/fetch_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class CelebrityDetailsRepository extends BaseCelebrityDetailsRepository{
  final BaseRemoteCelebrityDetailsDataSource baseRemoteCelebrityDetailsDataSource;
  CelebrityDetailsRepository(this.baseRemoteCelebrityDetailsDataSource);
  @override
  Future<Either<FetchException, CelebrityDetails>> getCelebrityDetails({required int id}) async{
    try{
      final result = await baseRemoteCelebrityDetailsDataSource.getCelebrityDetails(id: id);
      return Right(result);
    }on FetchException catch (failure){
      return Left(FetchException(failure.message));
    }catch(error){
      debugPrint(error.toString());
      return const Left(FetchException('An unexpected error occurred!'));
    }
  }

}