import 'package:timesnap/app/module/entity/attendance.dart';
import 'package:timesnap/app/module/repository/attendance_repository.dart';
import 'package:timesnap/core/network/data_state.dart';
import 'package:timesnap/core/use_case/app_use_case.dart';

class AttendanceGetByMonthYear extends AppUseCase<
Future<DataState<List<AttendanceEntity>>>, AttendanceParamGetEntity>{
  final AttendanceRepository _attendanceRepository;

  AttendanceGetByMonthYear(this._attendanceRepository);
  
  @override
  Future<DataState<List<AttendanceEntity>>> call(
    {AttendanceParamGetEntity? param}) {
    return _attendanceRepository.getByMonthYear(param!);
  }
}