import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:timesnap/app/module/entity/attendance.dart';
import 'package:timesnap/app/presentation/detail_atendance/detail_attendance_page.dart';
import 'package:timesnap/app/presentation/face_recognition/face_recognition_page.dart';
import 'package:timesnap/app/presentation/home/home_notifier.dart';
import 'package:timesnap/app/presentation/intro/login_page.dart';
import 'package:timesnap/app/presentation/leave/leave_page.dart';
import 'package:timesnap/core/helper/date_time_helper.dart';
import 'package:timesnap/core/helper/dialog_helper.dart';
import 'package:timesnap/core/helper/global_helper.dart';
import 'package:timesnap/core/helper/shared_preferences_helper.dart';
import 'package:timesnap/core/widget/app_widget.dart';

class HomePage extends AppWidget<HomeNotifier, void, void> {
  // Move this to be a property properly managed with setState
  late int _currentIndex = 0;
  
  @override
  void checkVariableBeforeUi(BuildContext context) {
    if (!notifier.isPhysicDevice) {
      alternatifErrorButton = ElevatedButton(
        onPressed: () {
          exit(0);
        },
        child: Text('Close'),
      );
    } else {
      alternatifErrorButton = null;
    }
  }

  @override
  Widget bodyBuild(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => notifier.init(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _headerLayout(context),
                _checkInLayout(context),
                _activityThisMonth(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _headerLayout(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(Icons.person, size: 30, color: AppColors.primaryColor),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notifier.name,
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.TITLE_MEDIUM,
                      )?.copyWith(                     
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        ),
                    ),
                    if (!notifier.isLeave)
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.location_city, color: AppColors.backgroundColor,),
                                SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    notifier.schedule?.office.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: GlobalHelper.getTextStyle(
                                      context,
                                      appTextStyle: AppTextStyle.BODY_MEDIUM,
                                    )?.copyWith(
                                      color: AppColors.backgroundColor
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.access_time, color: AppColors.backgroundColor,),
                                SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    notifier.schedule?.shift.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: GlobalHelper.getTextStyle(
                                      context,
                                      appTextStyle: AppTextStyle.BODY_MEDIUM,
                                    )?.copyWith(
                                      color: AppColors.backgroundColor
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              IconButton(
            onPressed: () => _onPressLogout(context),
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            color: AppColors.backgroundColor,
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.black87),
                    SizedBox(width: 8),
                    Text(
                      DateTimeHelper.formatDateTime(
                        dateTime: DateTime.now(),
                        format: 'EEE, dd MMM yyyy',
                      ),
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    (notifier.schedule?.isWfa ?? false) ? 'WFA' : 'WFO',
                    style: GlobalHelper.getTextStyle(
                      context,
                      appTextStyle: AppTextStyle.LABEL_SMALL,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkInLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _timeStatusLayout(
                context,
                'Check-In',
                notifier.attendanceToday?.startTime ?? '--:--',
                Icons.login_outlined,
              ),
              SizedBox(width: 40),
              Container(
                width: 1,
                height: 60,
                color: Colors.grey[300],
              ),
              SizedBox(width: 40),
              _timeStatusLayout(
                context,
                'Check-Out',
                notifier.attendanceToday?.endTime ?? '--:--',
                Icons.logout_outlined,
              ),
            ],
          ),
          SizedBox(height: 24),
          if (notifier.isLeave)
            Text(
              "You're on Leave",
              style: GlobalHelper.getTextStyle(
                context,
                appTextStyle: AppTextStyle.TITLE_LARGE,
              )?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () => _onPressCreateAttendance(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  'Check-In',
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.BODY_MEDIUM,
                  )?.copyWith(color: AppColors.backgroundColor),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _timeStatusLayout(BuildContext context, String label, String time, IconData icon) {
    return Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.grey[400],
            size: 24,
          ),
        ),
        SizedBox(height: 8),
        Text(
          time,
          style:GlobalHelper.getTextStyle(
                context,
                appTextStyle: AppTextStyle.TITLE_LARGE,
              )?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
        Text(
          label,
          style:GlobalHelper.getTextStyle(
                context,
                appTextStyle: AppTextStyle.TITLE_LARGE,
              )?.copyWith(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

Widget _activityThisMonth(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    padding: EdgeInsets.all(16),
    constraints: BoxConstraints(
      minHeight: screenHeight - kToolbarHeight - 200, // Reduced min height to avoid overflow
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your Activities',
              style: GlobalHelper.getTextStyle(
                context,
                appTextStyle: AppTextStyle.TITLE_MEDIUM,
              ),
            ),
            TextButton(
              onPressed: () => _onPressSeeAll(context),
              child: Text(
                'See More',
                style:GlobalHelper.getTextStyle(
                context,
                appTextStyle: AppTextStyle.BODY_MEDIUM,
              )?.copyWith(fontSize: 12,
              color: Colors.blue),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: notifier.listAttendanceThisMonth.length,
          separatorBuilder: (context, index) => Divider(
            height: 1, 
            thickness: 1, 
            color: Colors.grey.withOpacity(0.2)
          ),
          itemBuilder: (context, index) {
            final item = notifier.listAttendanceThisMonth[
                notifier.listAttendanceThisMonth.length - index - 1];
            return _activityItem(context, item);
          },
        ),
      ],
    ),
  );
}

Widget _activityItem(BuildContext context, AttendanceEntity item) {
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      (notifier.schedule?.isWfa ?? false) ? 'WFA' : 'WFO',
                      style:  GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(fontSize: 12,
                        
                        fontWeight: FontWeight.w500,
                      )
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
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
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
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
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
  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            // Already on Home
            break;
          case 1:
            _onPressCreateAttendance(context);
            break;
          case 2:
            _onPressSeeAll(context);
            break;
          case 3:
            _onPressLeave(context);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time),
          label: 'Presensi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.approval),
          label: 'Permission',
        ),
      ],
    );
  }

  Future<void> _onPressCreateAttendance(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FaceRecognitionPage()),
    );
    notifier.init();
  }

  Future<void> _onPressLogout(BuildContext context) async {
    await SharedPreferencesHelper.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  void _onPressSeeAll(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailAttendancePage()),
    );
  }

  void _onPressMenu(BuildContext context) {
    DialogHelper.showBottomDialog(
      context: context,
      content: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _onPressLeave(context),
              icon: Icon(Icons.leave_bags_at_home),
              label: Text('Leave Request'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _onPressLogout(context),
              icon: Icon(Icons.logout),
              label: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  void _onPressLeave(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => LeavePage())
    );
  }
}