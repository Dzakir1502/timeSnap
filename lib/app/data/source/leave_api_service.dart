
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';
import 'package:timesnap/core/constant/constant.dart';
import 'package:timesnap/core/network/data_state.dart';

part 'leave_api_service.g.dart';


@RestApi(baseUrl: BASE_URL)
abstract class LeaveApiService {
  factory LeaveApiService(Dio dio) {
    return _LeaveApiService(dio);
  }

  @POST('/api/leaves')
  Future<HttpResponse<DataState>> send({
    @Body() required Map<String, dynamic> body,
  });
}
