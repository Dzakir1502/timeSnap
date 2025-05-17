import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:timesnap/app/presentation/map/map_notifier.dart';
import 'package:timesnap/core/helper/global_helper.dart';
import 'package:timesnap/core/helper/location_helper.dart';
import 'package:timesnap/core/widget/app_widget.dart';
import 'package:timesnap/core/widget/loading_app_widget.dart';

class MapPage extends AppWidget<MapNotifier, void, void> {
  @override
  void checkVariableBeforeUi(BuildContext context) {
    if (!notifier.isGrantedLocation) {
      alternatifErrorButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
              ),
        onPressed: () async {
          await LocationHelper.showDialogLocationPermission(context);
          notifier.checkLocationPermission();
        },
        child: Text('Setuju'),
      );
    } else if (!notifier.isEnabledLocation) {
      alternatifErrorButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
              ),
        onPressed: () async {
          LocationHelper.openLocationSettings();
        },
        child: Text('Aktifkan Lokasi'),
      );
    } else if (notifier.isMockedLocation) {
      alternatifErrorButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
              ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Close'),
      );
    } else {
      alternatifErrorButton = null;
    }
  }

  @override
  void checkVariableAfterUi(BuildContext context) {
    if (notifier.isSuccess) {
      Navigator.pop(context);
    }
  }

  @override
  AppBar? appBarBuild(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0xFF0E3C63),
    elevation: 0,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title:  Text(
      'Make Attendance',
      style:GlobalHelper.getTextStyle(
          context,
          appTextStyle: AppTextStyle.TITLE_LARGE,
        )?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    centerTitle: false,
  );
}

  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: OSMFlutter(
              controller: notifier.mapController,
              osmOption: OSMOption(
                zoomOption: ZoomOption(
                  initZoom: 15.5,
                  maxZoomLevel: 17.5,
                  minZoomLevel: 10,
                ),
              ),
              onMapIsReady: (p0) {
                if (p0) {
                  notifier.mapIsReady();
                }
              },
              mapIsLoading: LoadingAppWidget(),
            ),
          ),
          _footerLayout(context),
        ],
      ),
    );
  }

_footerLayout(BuildContext context) {
  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 5,
          offset: Offset(0, -2),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Time display
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notifier.schedule.shift.startTime,
                  style: GlobalHelper.getTextStyle(
                              context,
                              appTextStyle: AppTextStyle.BODY_SMALL,
                            )?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  (notifier.schedule.isWfa) ? 'WFA' : 'WFO',
                  style:  GlobalHelper.getTextStyle(
                              context,
                              appTextStyle: AppTextStyle.TITLE_MEDIUM,
                            )?.copyWith(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            
            // Company/Office info
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Icon(Icons.access_time,  size: 16, color: Colors.blue),
                    SizedBox(height: 10,),
                    Icon(Icons.business, size: 16, color: Colors.blue),
                  ],
                ),
                SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notifier.schedule.shift.name,
                      style:  GlobalHelper.getTextStyle(
                              context,
                              appTextStyle: AppTextStyle.BODY_SMALL,
                            )?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),        
                    SizedBox(height: 10,),
                    Text(
                  notifier.schedule.office.name,
                  style: GlobalHelper.getTextStyle(
                              context,
                              appTextStyle: AppTextStyle.BODY_SMALL,
                            )?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
                  ],
                ),

              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        // Check-Out button
        Container(
          width: double.maxFinite,
          height: 44,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0D3B66), // Dark blue color from the image
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            onPressed: (notifier.isEnableSubmitButton) ? _onPressSubmit : null,
            child: Text(
              'Send Attendance',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


  _onPressSubmit() {
    notifier.send();
  }
}
