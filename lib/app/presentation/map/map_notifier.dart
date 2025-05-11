import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timesnap/app/module/entity/attendance.dart';
import 'package:timesnap/app/module/entity/schedule.dart';
import 'package:timesnap/app/module/use_case/attendance_send.dart';
import 'package:timesnap/app/module/use_case/schedule_get.dart';
import 'package:timesnap/core/helper/location_helper.dart';
import 'package:timesnap/core/provider/app_provider.dart';

class MapNotifier extends AppProvider {
  final ScheduleGetUsecase _scheduleGetUsecase;
  final AttendanceSendUseCase _attendanceSendUseCase;

  MapNotifier(this._scheduleGetUsecase, this._attendanceSendUseCase) {
    init();
  }

  bool _isSuccess = false;
  bool _isEnableSubmitButton = false;
  MapController _mapController = MapController.withPosition(
    initPosition: GeoPoint(latitude: -6.17549964024, longitude: 106.827149391),
  );

  late ScheduleEntity _schedule;
  late CircleOSM _circle;
  late StreamSubscription<Position> _streamCurrenLocation;
  GeoPoint? _currentLocation;
  bool _isGrantedLocation = false;
  bool _isEnabledLocation = false;
  bool _isMockedLocation = false;

  MapController get mapController => _mapController;
  ScheduleEntity get schedule => _schedule;
  bool get isGrantedLocation => _isGrantedLocation;
  bool get isEnabledLocation => _isEnabledLocation;
  bool get isSuccess => _isSuccess;
  bool get isEnableSubmitButton => _isEnableSubmitButton;
  bool get isMockedLocation => _isMockedLocation;

  @override
  void init() async {
    await _getSchedule();
    await _getEnableAndPermission();
  }

  _getEnableAndPermission() async {
    showLoading();
    _isGrantedLocation = await LocationHelper.isGrantedLocationPermission();
    if (_isGrantedLocation) {
      _isEnabledLocation = await LocationHelper.isEnabledLocationService();
      if (!_isEnabledLocation) {
        errorMessage = 'Aktifkan Gps Terlebih Dahulu';
      }
    } else {
      errorMessage = 'Harap Menyetujui Perizinan';
    }
    hideLoading();
  }

  _getSchedule() async {
    showLoading();
    final response = await _scheduleGetUsecase();
    if (response.success) {
      _schedule = response.data!;
      _circle = CircleOSM(
        key: 'Center-Point',
        centerPoint: GeoPoint(
          latitude: _schedule.office.latitude,
          longitude: _schedule.office.longitude,
        ),
        radius: _schedule.office.radius,
        color: Colors.blue.withOpacity(0.5),
        strokeWidth: 2,
        borderColor: Colors.black,
      );
    } else {
      errorMessage = response.message;
    }
    hideLoading();
  }

  checkLocationPermission() async {
    _isGrantedLocation = await LocationHelper.isGrantedLocationPermission();
    if (!_isGrantedLocation && !isDispose) {
      checkLocationPermission();
    } else {
      errorMessage = '';
      init();
    }
  }

  checkLocationService() async {
    _isEnabledLocation = await LocationHelper.isEnabledLocationService();
    if (!_isEnabledLocation && !isDispose) {
      checkLocationService();
    } else {
      errorMessage = '';
      init();
    }
  }

  mapIsReady() async {
    _openStreamCurrentLocation();
    await mapController.drawCircle(_circle);
  }

  _openStreamCurrentLocation() async {
    _streamCurrenLocation = Geolocator.getPositionStream().listen((position) {
      if (position.isMocked) {
        _isMockedLocation = true;
        errorMessage = 'You are Using a Fake Location';
        _closeStreamCurrentLocation();
        notifyListeners();
      }else{
           if (!isDispose) {
        if (_currentLocation != null)
          _mapController.removeMarker(_currentLocation!);
        _currentLocation = GeoPoint(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        _mapController.addMarker(
          _currentLocation!,
          markerIcon: MarkerIcon(
            icon: Icon(Icons.account_circle, color: Colors.red, size: 30),
          ),
        );
        _mapController.moveTo(_currentLocation!, animate: true);
        _validationSubmitButton();
      } else {
        _closeStreamCurrentLocation();
      }
      }
     
    });
  }

  _closeStreamCurrentLocation() {
    _streamCurrenLocation.cancel();
  }

  _validationSubmitButton() {
    if (_schedule.isWfa) {
      _isEnableSubmitButton = true;
    } else {
      final inCircle = LocationHelper.isLocationInCircle(
        _circle,
        _currentLocation!,
      );
      if (inCircle != _isEnableSubmitButton) {
        _isEnableSubmitButton = inCircle;
        notifyListeners();
      }
    }
  }

  send() async {
    showLoading();
    final response = await _attendanceSendUseCase(
      param: AttendanceParamEntity(
        latitude: _currentLocation!.latitude,
        longitude: _currentLocation!.longitude,
      ),
    );
    if (response.success) {
      _isSuccess = true;
    } else {
      snackBarMessage = response.message;
    }
    hideLoading();
  }
}
