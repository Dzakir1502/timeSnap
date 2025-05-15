import 'package:timesnap/app/module/entity/leave.dart';
import 'package:timesnap/app/module/repository/leave_repository.dart';
import 'package:timesnap/core/network/data_state.dart';
import 'package:timesnap/core/use_case/app_use_case.dart';

class LeaveSendUseCase extends AppUseCase<Future<DataState>, LeaveParamEntity> {
  final LeaveRepository _leaveRepository;

  LeaveSendUseCase(this._leaveRepository);

  @override
  Future<DataState> call({LeaveParamEntity? param}) {
    return _leaveRepository.send(param!);
  }
}
