import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timesnap/app/presentation/leave/leave_notifier.dart';
import 'package:timesnap/core/helper/date_time_helper.dart';
import 'package:timesnap/core/helper/global_helper.dart';
import 'package:timesnap/core/widget/app_widget.dart';

class LeavePage extends AppWidget<LeaveNotifier, void, void> {
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
      'Leave Page',
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
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style:  GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(             
                        fontSize: 14,
                        ),
              controller: notifier.startDateController,
              onTap: () => _onPressDate(context, notifier.startDateController),
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Start Date',
                labelStyle:  GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(             
                        fontSize: 14,
                        ),
                fillColor: Color(0xFFF5F7FA),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(             
                        fontSize: 14,
                        ), 
              controller: notifier.endDateController,
              onTap: () => _onPressDate(context, notifier.endDateController),
              readOnly: true,
              decoration: InputDecoration(
                labelStyle: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(             
                        fontSize: 14,
                        ),
                labelText: 'End Date',
                fillColor: Color(0xFFF5F7FA),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              style:  GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(             
                        fontSize: 14,
                        ),
              controller: notifier.reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                labelStyle:  GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(             
                        fontSize: 14,
                        ),
                labelText: 'Reason',
                fillColor: Color(0xFFF5F7FA),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () => _onPressSend(context),
                child: Text(
                  'Send',
                  style:  GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_SMALL,
                      )?.copyWith(             
                        color: AppColors.backgroundColor,
                        fontSize: 14,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  @override
  void checkVariableAfterUi(BuildContext context) {
    if (notifier.isSuccess) {
      Navigator.pop(context);
    }
  }

  _onPressDate(BuildContext context, TextEditingController controller) async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (dateTime != null) {
      final dateTimeString = DateTimeHelper.formatDateTime(
        dateTime: dateTime,
        format: 'yyyy-MM-dd',
      );
      controller.text= dateTimeString;
    }
  }


  _onPressSend(BuildContext context) {
    notifier.send();
  }
}
