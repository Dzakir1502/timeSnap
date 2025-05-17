import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
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
    backgroundColor: AppColors.primaryColor,
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
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownMenu(
                      expandedInsets: EdgeInsets.symmetric(horizontal: 1),
                      label: Text('Month'),
                      dropdownMenuEntries: notifier.monthListDropdown,
                      initialSelection: notifier.monthListDropdown,
                      controller: notifier.monthController,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownMenu(
                      expandedInsets: EdgeInsets.symmetric(horizontal: 1),
                      label: Text('Year'),
                      dropdownMenuEntries: notifier.yearListDropdown,
                      initialSelection: notifier.yearListDropdown,
                      controller: notifier.yearController,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: IconButton(
                    onPressed: _onPressSearch,
                    icon: Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // List of attendance
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: notifier.listAttendance.length,
              separatorBuilder: (context, index) => Divider(
              height: 1, 
              thickness: 1, 
              color: Colors.grey.withOpacity(0.2)
            ),
              itemBuilder: (context, index) {
                final item = notifier.listAttendance[
                    notifier.listAttendance.length - index - 1];
                return _itemAttendance(context, item);
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _itemAttendance(BuildContext context, AttendanceEntity item) {
  // Parse date to get day number
  final DateTime dateTime = item.date != null 
      ? DateTime.parse(item.date!) 
      : DateTime.now();

  final dayNumber = dateTime.day.toString();
  final dateFormat = DateFormat('EEEE, dd MMM yyyy');
  final formattedDate = dateFormat.format(dateTime);
    String checkInTime = "-";
  String checkOutTime = "-";
  
  try {
    if (item.startTime.isNotEmpty) {
      final startParts = item.startTime.split(':');
      if (startParts.length >= 2) {
        final hour = int.parse(startParts[0]);
        final minute = int.parse(startParts[1]);
        final timeOfDay = hour >= 12 ? 'PM' : 'AM';
        final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        checkInTime = '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $timeOfDay';
      }
    }
    
    if (item.endTime.isNotEmpty) {
      final endParts = item.endTime.split(':');
      if (endParts.length >= 2) {
        final hour = int.parse(endParts[0]);
        final minute = int.parse(endParts[1]);
        final timeOfDay = hour >= 12 ? 'PM' : 'AM';
        final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        checkOutTime = '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $timeOfDay';
      }
    }
  } catch (e) {
    // Handle parsing errors by keeping defaults
    print('Error parsing time: $e');
  }
  
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Day number circle
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              dayNumber,
              style:GlobalHelper.getTextStyle(context,
                      appTextStyle: AppTextStyle.LABEL_SMALL
                    )?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
            ),
          ),
        ),
        SizedBox(width: 12),
        // Activity details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: GlobalHelper.getTextStyle(context,
                      appTextStyle: AppTextStyle.LABEL_SMALL
                    )?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "Check-In",
                    style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(                
                        fontSize: 14,
                        ), 
                  ),
                  Spacer(),
                  Text(
                    checkInTime,
                    style:  GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "Check-Out",
                    style:  GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(                
                        fontSize: 14,
                        ),
                  ),
                  Spacer(),
                  Text(
                    checkOutTime,
                    style:  GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )
                  ),
                ],
              ),
            ],
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
