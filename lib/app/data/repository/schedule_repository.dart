import 'dart:convert';

import 'package:timesnap/app/data/source/schedule_api_service.dart';
import 'package:timesnap/app/module/entity/schedule.dart';
import 'package:timesnap/app/module/repository/schedule_repository.dart';
import 'package:timesnap/core/network/data_state.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleApiService _scheduleApiService;

  ScheduleRepositoryImpl(this._scheduleApiService);

  @override
  Future<DataState<ScheduleEntity?>> get() {
    return handleResponse(() => _scheduleApiService.get(), (json) {
      if (json != null) {
        return ScheduleEntity.fromJson(json);
        
      } else {
        return null;
      }
    });
  }
}
