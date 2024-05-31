import 'package:axis_task/modules/home/data/datasource/remote_celebrity_data_source.dart';
import 'package:axis_task/modules/home/domain/repository/base_celebrity_repository.dart';
import 'package:axis_task/utils/network/remote/fetch_exception.dart';
import 'package:dartz/dartz.dart';

class CelebrityRepository extends BaseCelebrityRepository{
  final BaseRemoteDataSource baseRemoteDataSource;

  CelebrityRepository(this.baseRemoteDataSource);
  @override
  Future<Either<FetchException,CelebrityModelResponse>> getPopularCelebrities({required int page}) async{
    final result = await baseRemoteDataSource.getPopularCelebrities(page: page);

    try{
      return Right(result);
    } on FetchException catch(failure){
      return Left(FetchException(failure.message));
    }
  }

}