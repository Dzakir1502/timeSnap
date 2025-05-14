import 'package:timesnap/app/module/entity/leave.dart';
import 'package:timesnap/core/network/data_state.dart';

abstract class LeaveRepository {
  Future<DataState> send(LeaveParamEntity param);
}
