import 'package:axis_task/modules/person/models/celebrity_details_mode.dart';

abstract class CelebrityDetailsStates {}

class CelebrityDetailsDataState extends CelebrityDetailsStates {
  CelebrityDetailsModel? celebrityDetails;
  CelebrityDetailsDataState({this.celebrityDetails});
}
