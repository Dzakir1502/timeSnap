import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:timesnap/app/data/repository/attendance_repository.dart';
import 'package:timesnap/app/data/repository/auth_repository.dart';
import 'package:timesnap/app/data/source/attendance_api_service.dart';
import 'package:timesnap/app/data/source/auth_api_service.dart';
import 'package:timesnap/app/module/repository/attendance_repository.dart';
import 'package:timesnap/app/module/repository/auth_repository.dart';
import 'package:timesnap/app/module/use_case/attendance_get_this_month.dart';
import 'package:timesnap/app/module/use_case/attendance_get_today.dart';
import 'package:timesnap/app/module/use_case/auth_login.dart';
import 'package:timesnap/app/presentation/home/home_notifier.dart';
import 'package:timesnap/app/presentation/intro/login_notifier.dart';
import 'package:timesnap/app/presentation/map/map_notifier.dart';
import 'package:timesnap/core/network/app_interceptor.dart';

final sl = GetIt.instance;
Future<void> initDependency() async {
  Dio dio = Dio();
  dio.interceptors.add(AppInterceptor());
  dio.interceptors.add(
    PrettyDioLogger(
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      requestHeader: true,
      compact: true,
    ),
  );
  sl.registerSingleton<Dio>(dio);

  // apiservice

  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));
  sl.registerSingleton<AttendanceApiService>(AttendanceApiService(sl()));
  // respository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<AttendanceRepository>(AttendanceRepositoryImpl(sl()));
  // usecase
  sl.registerSingleton<AuthLoginUseCase>(AuthLoginUseCase(sl()));
  sl.registerSingleton<AttendanceGetTodayUseCase>(
    AttendanceGetTodayUseCase(sl()));
  sl.registerSingleton<AttendanceGetMonthUseCase>(
    AttendanceGetMonthUseCase(sl()));
  // provider
  sl.registerFactoryParam<LoginNotifier, void, void>(
    (param1, param2) => LoginNotifier(sl()),
  );
  sl.registerFactoryParam<HomeNotifier, void, void>(
    (param1, param2) => HomeNotifier(sl(), sl()),
  );
  sl.registerFactoryParam<MapNotifier, void, void>(
    (param1, param2) => MapNotifier(),
  );
}
