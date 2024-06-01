import 'package:axis_task/modules/person/domain/entities/celebrity_details.dart';
import 'package:axis_task/utils/network/remote/fetch_exception.dart';
import 'package:dartz/dartz.dart';

abstract class BaseCelebrityDetailsRepository{
Future<Either<FetchException,CelebrityDetails>> getCelebrityDetails({required int id});
}