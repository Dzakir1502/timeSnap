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
    return AppBar(title: Text('Leave'));
  }

  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: notifier.startDateController,
              onTap: () => _onPressDate(context, notifier.startDateController),
              readOnly: true,
              decoration: InputDecoration(
                label: Text(
                  'Start Date',
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.BODY_MEDIUM,
                  ),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: notifier.endDateController,
              onTap: () => _onPressDate(context, notifier.endDateController),
              readOnly: true,
              decoration: InputDecoration(
                label: Text(
                  'End Date',
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.BODY_MEDIUM,
                  ),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: notifier.reasonController,
              decoration: InputDecoration(
                label: Text(
                  'Reason',
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.BODY_MEDIUM,
                  ),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.maxFinite,
              child: FilledButton(
                onPressed: () => _onPressSend(context),
                child: Text('Send'),
              ),
            ),
          ],
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
