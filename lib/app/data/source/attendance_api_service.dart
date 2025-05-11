import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:timesnap/core/constant/constant.dart';
import 'package:timesnap/core/network/data_state.dart';

part 'attendance_api_service.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class AttendanceApiService {
  factory AttendanceApiService(Dio dio) {
    return _AttendanceApiService(dio);
  }
  @GET('/api/get-attendance-today')
  Future<HttpResponse<DataState>> getAttendanceToday();

  @POST('/api/store-attendance')
  Future<HttpResponse<DataState>> sendAttendance({
    @Body() required Map<String, dynamic> body,
  });

  @GET('/api/get-attendance-by-month-year/{month}/{year}')
  Future<HttpResponse<DataState>> getAttendanceByMonthYear({
    @Path('month') required String month,
    @Path('year') required String year,
  });
}
