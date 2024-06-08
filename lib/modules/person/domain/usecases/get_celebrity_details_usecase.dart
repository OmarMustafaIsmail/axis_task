import 'package:axis_task/modules/person/domain/entities/celebrity_details.dart';
import 'package:axis_task/modules/person/domain/repository/base_celebrity_details_repositoy.dart';
import 'package:axis_task/utils/network/remote/fetch_exception.dart';
import 'package:dartz/dartz.dart';

class GetCelebrityDetailsUseCase{
  final BaseCelebrityDetailsRepository baseCelebrityDetailsRepository;
  const GetCelebrityDetailsUseCase(this.baseCelebrityDetailsRepository);

  Future<Either<FetchException,CelebrityDetails>> execute({required int id})async{
    return await baseCelebrityDetailsRepository.getCelebrityDetails(id: id);
  }
}