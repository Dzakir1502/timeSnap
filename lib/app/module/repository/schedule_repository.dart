import 'package:timesnap/app/module/entity/schedule.dart';
import 'package:timesnap/core/network/data_state.dart';

abstract class ScheduleRepository {
  Future<DataState<ScheduleEntity?>> get();
}