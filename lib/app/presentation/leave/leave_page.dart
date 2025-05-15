import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timesnap/app/presentation/leave/leave_notifier.dart';
import 'package:timesnap/core/helper/global_helper.dart';
import 'package:timesnap/core/widget/app_widget.dart';

class LeavePage extends AppWidget<LeaveNotifier, void, void> {
  @override
  AppBar? appBarBuild(BuildContext context) {
    return AppBar(title: Text('Leave'));
  }

  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(child: Padding(
      padding: const EdgeInsets.all(10),
      child:  Column(
        children :[
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              label: Text('Start Date', style: GlobalHelper.getTextStyle(context, appTextStyle: AppTextStyle.BODY_MEDIUM),)
            )
          ),
          SizedBox(height: 10,),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              label: Text('End Date', style: GlobalHelper.getTextStyle(context, appTextStyle: AppTextStyle.BODY_MEDIUM),)
            )
          ),
          SizedBox(height: 10,),
          TextField(
            decoration: InputDecoration(
              label: Text('Reason', style: GlobalHelper.getTextStyle(context, appTextStyle: AppTextStyle.BODY_MEDIUM),)
            )
          ),
          SizedBox(height: 30,),
          Container(width: double.maxFinite,child: FilledButton(onPressed: () => _onPressSend(context), child: Text('Send')),)
        ]
      ),
      )
    );
  }

  _onPressSend(BuildContext context){

  }
}
