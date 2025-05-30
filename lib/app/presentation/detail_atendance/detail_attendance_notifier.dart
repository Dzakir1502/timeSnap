import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timesnap/app/module/entity/attendance.dart';
import 'package:timesnap/app/module/use_case/attendance_get_by_month_year.dart';
import 'package:timesnap/core/provider/app_provider.dart';

class DetailAttendanceNotifier extends AppProvider{
  final AttendanceGetByMonthYear _attendanceGetByMonthYear;
  

  DetailAttendanceNotifier(this._attendanceGetByMonthYear){
    init();
  }

  TextEditingController _monthController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

  List<DropdownMenuEntry<int>> _monthListDropdown = [
    DropdownMenuEntry(value: 1, label:'Januari' ),
    DropdownMenuEntry(value: 2, label:'Februari' ),
    DropdownMenuEntry(value: 3, label:'Maret' ),
    DropdownMenuEntry(value: 4, label:'April' ),
    DropdownMenuEntry(value: 5, label:'Mei' ),
    DropdownMenuEntry(value: 6, label:'Juni' ),
    DropdownMenuEntry(value: 7, label:'Juli' ),
    DropdownMenuEntry(value: 8, label:'Agustus' ),
    DropdownMenuEntry(value: 9, label:'September' ),
    DropdownMenuEntry(value: 10, label:'Oktober' ),
    DropdownMenuEntry(value: 11, label:'November' ),
    DropdownMenuEntry(value: 12, label:'Desember' ),
  ];

  List<DropdownMenuEntry<int>> _yearListDropdown = [
    DropdownMenuEntry(value: 2025, label: '2025')
  ];

  List<AttendanceEntity> _listAttendance = [];

    TextEditingController get monthController  => _monthController;
  TextEditingController get yearController  =>_yearController;

  List<DropdownMenuEntry<int>> get monthListDropdown => _monthListDropdown;
  List<DropdownMenuEntry<int>> get yearListDropdown => _yearListDropdown;
  List<AttendanceEntity> get listAttendance => _listAttendance;



  @override
  void init() {
    // TODO: implement init    
  }

  search() async{
    showLoading();
    final month = _monthListDropdown
    .where((element) => element.label == _monthController.text)
    .first
    .value;

    final year = _yearListDropdown
    .where((element) => element.label == _yearController.text)
    .first
    .value;

    final response = await _attendanceGetByMonthYear(
      param: AttendanceParamGetEntity(month: month, year: year));
      if(response.success){
        _listAttendance = response.data!;
      } else{
        errorMessage = response.message;
      }

      hideLoading();
  }


}