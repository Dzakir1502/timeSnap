import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:timesnap/core/constant/constant.dart';
import 'package:timesnap/core/network/data_state.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) {
    return _AuthApiService(dio);
  }

  @POST('/api/login')
  Future<HttpResponse<DataState>> login({
    @Body() required Map<String, dynamic> body,
  });
}
