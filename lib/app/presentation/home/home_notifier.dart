import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:timesnap/app/data/model/attendance.dart';
import 'package:timesnap/app/module/entity/attendance.dart';
import 'package:timesnap/app/module/entity/schedule.dart';
import 'package:timesnap/app/module/use_case/attendance_get_this_month.dart';
import 'package:timesnap/app/module/use_case/attendance_get_today.dart';
import 'package:timesnap/app/module/use_case/schedule_get.dart';
import 'package:timesnap/core/constant/constant.dart';
import 'package:timesnap/core/helper/shared_preferences_helper.dart';
import 'package:timesnap/core/provider/app_provider.dart';

class HomeNotifier extends AppProvider {
  final AttendanceGetTodayUseCase _attendanceGetTodayUseCase;
  final AttendanceGetMonthUseCase _attendanceGetMonthUseCase;
  final ScheduleGetUsecase _scheduleGetUsecase;

  HomeNotifier(
    this._attendanceGetTodayUseCase,
    this._attendanceGetMonthUseCase,
    this._scheduleGetUsecase,
  ) {
    init();
  }
  
  String _name = '';
  bool _isPhysicDevice = true;

  AttendanceEntity? _attendanceToday;
  List<AttendanceEntity> _listAttendanceThisMonth = [];
  late ScheduleEntity _schedule;

  AttendanceEntity? get attendanceToday => _attendanceToday;
  List<AttendanceEntity> get listAttendanceThisMonth =>
      _listAttendanceThisMonth;

  ScheduleEntity get schedule => _schedule;
  bool get isPhysicDevice => _isPhysicDevice;
  
  String  get name => _name;

  @override
  void init() async {
    await _getUserDetail();
    // await _getDeviceInfo();
    if (errorMessage.isEmpty) await _getAttendanceToday();
    if (errorMessage.isEmpty) await _getAttendanceThisMonth();
    if (errorMessage.isEmpty) await _getSchedule();
  }

  _getUserDetail() async{
    showLoading();
    _name = await SharedPreferencesHelper.getString(PREF_NAME);
    hideLoading();
  }

  _getDeviceInfo() async {
    showLoading();
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      _isPhysicDevice = androidInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      final iOSInfo = await DeviceInfoPlugin().iosInfo;
      _isPhysicDevice = iOSInfo.isPhysicalDevice;
    }

    if (!_isPhysicDevice)
      errorMessage = 'Anda Harus Memakai Perangkat Android/IOS';
    hideLoading();
  }

  _getAttendanceToday() async {
    showLoading();
    final response = await _attendanceGetTodayUseCase();
    if (response.success) {
      _attendanceToday = response.data;
    } else {
      errorMessage = response.message;
    }

    hideLoading();
  }

  _getAttendanceThisMonth() async {
    showLoading();
    final response = await _attendanceGetMonthUseCase();
    if (response.success) {
      _listAttendanceThisMonth = response.data!;
    } else {
      errorMessage = response.message;
    }
    hideLoading();
  }

  _getSchedule() async {
    showLoading();
    final response = await _scheduleGetUsecase();
    if (response.success) {
      _schedule = response.data!;
    } else {
      errorMessage = response.message;
    }
    hideLoading();
  }
}
