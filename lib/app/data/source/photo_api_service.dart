import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:timesnap/core/constant/constant.dart';
import 'package:dio/dio.dart';
import 'package:timesnap/core/network/data_state.dart';

part 'photo_api_service.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class PhotoApiService {
  factory PhotoApiService(Dio dio){
  return _PhotoApiService(dio);
  }

  @GET('/api/get-photo')
  Future<HttpResponse<DataState>> get();
}