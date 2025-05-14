import 'package:timesnap/app/module/entity/schedule.dart';
import 'package:timesnap/app/module/repository/schedule_repository.dart';
import 'package:timesnap/core/network/data_state.dart';
import 'package:timesnap/core/use_case/app_use_case.dart';

class ScheduleGetUsecase
    extends AppUseCase<Future<DataState<ScheduleEntity?>>, void> {
  final ScheduleRepository _scheduleRepository;

  ScheduleGetUsecase(this._scheduleRepository);

  @override
  Future<DataState<ScheduleEntity?>> call({void param}) {
    return _scheduleRepository.get();
  }
}
