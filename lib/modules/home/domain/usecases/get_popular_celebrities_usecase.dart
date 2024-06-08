import 'package:axis_task/modules/home/data/datasource/remote_celebrity_data_source.dart';
import 'package:axis_task/modules/home/domain/repository/base_celebrity_repository.dart';
import 'package:axis_task/utils/network/remote/fetch_exception.dart';
import 'package:dartz/dartz.dart';

class GetPopularCelebritiesUseCase{
  final BaseCelebrityRepository baseCelebrityRepository;
  const GetPopularCelebritiesUseCase(this.baseCelebrityRepository);

  Future<Either<FetchException,CelebrityModelResponse>> execute({required int page})async{
    return await baseCelebrityRepository.getPopularCelebrities(page: page);
  }
}