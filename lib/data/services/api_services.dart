import 'package:dio/dio.dart';
import 'package:meetings/config/constent.dart';
import 'package:meetings/data/model/base_response.dart';
import 'package:meetings/data/model/meeting_date_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: endPoint)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @GET('/meeting-calender-list')
  Future<BaseResponse<List<MeetingDateModel>>> getMeetingList({
    @Query('year') int? year,
    @Query('month') int? month,
  });
}
