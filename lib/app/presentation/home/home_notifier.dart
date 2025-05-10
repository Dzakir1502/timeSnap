import 'package:timesnap/app/data/model/attendance.dart';
import 'package:timesnap/app/module/entity/attendance.dart';
import 'package:timesnap/app/module/use_case/attendance_get_this_month.dart';
import 'package:timesnap/app/module/use_case/attendance_get_today.dart';
import 'package:timesnap/core/provider/app_provider.dart';

class HomeNotifier extends AppProvider{
  final AttendanceGetTodayUseCase _attendanceGetTodayUseCase;
  final AttendanceGetMonthUseCase _attendanceGetMonthUseCase;

  HomeNotifier(this._attendanceGetTodayUseCase, this._attendanceGetMonthUseCase){
    init();
  }

  AttendanceEntity? _attendanceToday;
  List<AttendanceEntity> _listAttendanceThisMonth = [];

  AttendanceEntity? get attendanceToday => _attendanceToday;
  List<AttendanceEntity> get listAttendanceThisMonth =>
  _listAttendanceThisMonth;
  @override
  void init() async{
    await _getAttendanceToday();
    if(errorMessage.isEmpty) await _getAttendanceThisMonth();
  }

  _getAttendanceToday() async{
    showLoading();
    final response = await _attendanceGetTodayUseCase();
    if(response.success){
      _attendanceToday = response.data;
    }else{
      errorMessage = response.message;
    }

    hideLoading();
  }
  
  _getAttendanceThisMonth() async{
    showLoading();
    final response = await _attendanceGetMonthUseCase();
    if(response.success){
      _listAttendanceThisMonth = response.data!;
    }else{
      errorMessage = response.message;
    }
    hideLoading();
  }
}