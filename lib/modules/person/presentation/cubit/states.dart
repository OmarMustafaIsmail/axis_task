import 'package:axis_task/modules/person/domain/entities/celebrity_details.dart';

abstract class CelebrityDetailsStates {}

class CelebrityDetailsDataState extends CelebrityDetailsStates {
  CelebrityDetails? celebrityDetails;
  CelebrityDetailsDataState({this.celebrityDetails});
}
