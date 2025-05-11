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
      alternatifErrorButton = FilledButton(
        onPressed: () async {
          await LocationHelper.showDialogLocationPermission(context);
          notifier.checkLocationPermission();
        },
        child: Text('Setuju'),
      );
    } else if (!notifier.isEnabledLocation) {
      alternatifErrorButton = FilledButton(
        onPressed: () async {
          LocationHelper.openLocationSettings();
        },
        child: Text('Aktifkan Lokasi'),
      );
    } else {
      alternatifErrorButton = null;
    }
  }

  @override
  AppBar? appBarBuild(BuildContext context) {
    return AppBar(
      title: Text(
        "Make Attendance",
        style: GlobalHelper.getTextStyle(
          context,
          appTextStyle: AppTextStyle.TITLE_LARGE,
        ),
      ),
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
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_city, size: 30),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notifier.schedule.office.name,
                            style: GlobalHelper.getTextStyle(
                              context,
                              appTextStyle: AppTextStyle.TITLE_MEDIUM,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color:
                                  GlobalHelper.getColorScheme(context).primary,
                            ),
                            child: Text(
                              (notifier.schedule.isWfa) ? 'WFA' : 'WFO',
                              style: GlobalHelper.getTextStyle(
                                context,
                                appTextStyle: AppTextStyle.BODY_SMALL,
                              )?.copyWith(
                                color:
                                    GlobalHelper.getColorScheme(
                                      context,
                                    ).onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time, size: 30),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notifier.schedule.shift.name,
                            style: GlobalHelper.getTextStyle(
                              context,
                              appTextStyle: AppTextStyle.TITLE_MEDIUM,
                            ),
                          ),
                          Text(
                            '${notifier.schedule.shift.startTime} - ${notifier.schedule.shift.endTime}',
                            style: GlobalHelper.getTextStyle(
                              context,
                              appTextStyle: AppTextStyle.BODY_SMALL,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            child: FilledButton(
              onPressed: () {},
              child: Text('Send attendance'),
            ),
          ),
        ],
      ),
    );
  }
}
