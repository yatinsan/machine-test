import 'package:meetings/data/model/base_response.dart';
import 'package:meetings/data/model/meeting_date_model.dart';
import 'package:meetings/data/services/api_services.dart';

class MeetingRepo {
  final ApiServices apiServices;

  MeetingRepo(this.apiServices);

  Future<BaseResponse<List<MeetingDateModel>>> getAllMeetings({
    int? year,
    int? month,
  }) {
    return apiServices.getMeetingList(month: month, year: year);
  }
}
