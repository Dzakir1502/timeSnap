import 'package:timesnap/app/module/entity/attendance.dart';
import 'package:timesnap/core/network/data_state.dart';

abstract class AttendanceRepository {
  Future<DataState<AttendanceEntity?>> getToday();
  Future<DataState<List<AttendanceEntity>>> getThisMonth();
}
