import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesnap/app/presentation/home/home_notifier.dart';
import 'package:timesnap/app/presentation/map/map_page.dart';
import 'package:timesnap/core/helper/date_time_helper.dart';
import 'package:timesnap/core/helper/global_helper.dart';
import 'package:timesnap/core/widget/app_widget.dart';

class HomePage extends AppWidget<HomeNotifier, void, void> {
  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _headerLayout(context),
          _todayLayout(context),
          Expanded(child: _thisMonthLayout(context)),
        ],
      ),
    );
  }

  _headerLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(Icons.person, size: 40),
            backgroundColor:
                GlobalHelper.getColorScheme(context).primaryContainer,
            radius: 30,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama Pegawai',
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.HEADLINE_SMALL,
                  )?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.location_city),
                          SizedBox(width: 5),
                          Text('Office'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.access_time),
                          Text('Siang'),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        ],
      ),
    );
  }

  _todayLayout(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: GlobalHelper.getColorScheme(context).primary,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: GlobalHelper.getColorScheme(context).onPrimary,
                ),
                child: Row(
                  children: [
                    Icon(Icons.today),
                    SizedBox(width: 5),
                    Text(
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      ),
                      DateTimeHelper.formatDateTime(
                        dateTime: DateTime.now(),
                        format: 'EEE, dd MMM yyyy',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),

              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: GlobalHelper.getColorScheme(context).onPrimary,
                ),
                child: Text(
                  'WFA',
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.LABEL_SMALL,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _timeTodayLayout(context, 'Datang', '23:00:00'),
              _timeTodayLayout(context, 'Pulang', '22:00:00'),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.maxFinite,
            child: FilledButton(
              onPressed: () => _onPressCreateAttendance(context),
              child: Text('Buat Kehadiran'),
              style: FilledButton.styleFrom(
                backgroundColor: GlobalHelper.getColorScheme(context).onPrimary,
                foregroundColor: GlobalHelper.getColorScheme(context).primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _thisMonthLayout(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: GlobalHelper.getColorScheme(context).primaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'presensi Terakhir',
            style: GlobalHelper.getTextStyle(
              context,
              appTextStyle: AppTextStyle.TITLE_LARGE,
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 1,
            color: GlobalHelper.getColorScheme(context).primary,
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Tgl',
                    style: GlobalHelper.getTextStyle(
                      context,
                      appTextStyle: AppTextStyle.TITLE_SMALL,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'Datang',
                    style: GlobalHelper.getTextStyle(
                      context,
                      appTextStyle: AppTextStyle.TITLE_SMALL,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'Balek',
                    style: GlobalHelper.getTextStyle(
                      context,
                      appTextStyle: AppTextStyle.TITLE_SMALL,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Container(
            height: 2,
            color: GlobalHelper.getColorScheme(context).primary,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder:
                (context, index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  height: 1,
                  color: GlobalHelper.getColorScheme(context).surface,
                ),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _itemThisMonth(context);
            },
          ),
        ],
      ),
    );
  }

  _timeTodayLayout(BuildContext context, String label, String time) {
    return Expanded(
      child: Column(
        children: [
          Text(
            time,
            style: GlobalHelper.getTextStyle(
              context,
              appTextStyle: AppTextStyle.HEADLINE_MEDIUM,
            )?.copyWith(
              color: GlobalHelper.getColorScheme(context).onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: GlobalHelper.getTextStyle(
              context,
              appTextStyle: AppTextStyle.BODY_MEDIUM,
            )?.copyWith(color: GlobalHelper.getColorScheme(context).onPrimary),
          ),
        ],
      ),
    );
  }

  _itemThisMonth(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: GlobalHelper.getColorScheme(context).primary,
              ),
              child: Text(
                '03\nJuli',
                style: GlobalHelper.getTextStyle(
                  context,
                  appTextStyle: AppTextStyle.LABEL_LARGE,
                )?.copyWith(
                  color: GlobalHelper.getColorScheme(context).onPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                '05:00:00',
                style: GlobalHelper.getTextStyle(
                  context,
                  appTextStyle: AppTextStyle.BODY_MEDIUM,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                '12:00:00',
                style: GlobalHelper.getTextStyle(
                  context,
                  appTextStyle: AppTextStyle.BODY_MEDIUM,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onPressCreateAttendance(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()
    ));
  }
}
