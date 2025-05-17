import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timesnap/app/module/entity/attendance.dart';
import 'package:timesnap/app/presentation/detail_atendance/detail_attendance_notifier.dart';
import 'package:timesnap/core/helper/date_time_helper.dart';
import 'package:timesnap/core/helper/global_helper.dart';
import 'package:timesnap/core/widget/app_widget.dart';

class DetailAttendancePage
    extends AppWidget<DetailAttendanceNotifier, void, void> {
  @override
 AppBar? appBarBuild(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0xFF0E3C53),
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
      'Detail Attendance',
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
    return SafeArea(child: SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: DropdownMenu(
                expandedInsets: EdgeInsets.symmetric(horizontal: 1),
                label: Text('Month'),
                dropdownMenuEntries: notifier.monthListDropdown,
                initialSelection:  notifier.monthListDropdown,
                controller: notifier.monthController,
              )),
              Expanded(child: DropdownMenu(
                expandedInsets: EdgeInsets.symmetric(horizontal: 1),
                label: Text('Year'),
                dropdownMenuEntries: notifier.yearListDropdown,
                initialSelection: notifier.yearListDropdown,
                controller: notifier.yearController,
              )),
              IconButton(onPressed: _onPressSearch, icon: Icon(Icons.search))
            ],
          ), SizedBox(height: 20,),
                  SizedBox(height: 5),
          Container(
            height: 1,
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Date',
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
                    'Come',
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
                    'Go Home',
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
            color: AppColors.primaryColor,
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
            itemCount: notifier.listAttendance.length,
            itemBuilder: (context, index) {
              final item = notifier.listAttendance[
              notifier.listAttendance.length -index - 1];
              return _itemThisMonth(context,item);
            },
          ),
        ],
      ),
    ));
  }

  _itemThisMonth(BuildContext context,AttendanceEntity item) {
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
                color: AppColors.primaryColor,
              ),
              child: Text(
                DateTimeHelper.formatDateTimeFromString(
                  dateTimeString: item.date!,
                  format: 'dd\nMMM',
                ),
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
                item.startTime,
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
                item.endTime,
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
  _onPressSearch(){
    notifier.search();
  }
}
