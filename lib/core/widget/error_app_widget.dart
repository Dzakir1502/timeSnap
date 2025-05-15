import 'package:flutter/material.dart';
import 'package:timesnap/app/presentation/intro/login_page.dart';
import 'package:timesnap/core/helper/global_helper.dart';
import 'package:timesnap/core/helper/shared_preferences_helper.dart';

class ErrorAppWidget extends StatelessWidget {
  final String description;
  final FilledButton? alternativeButton;
  final void Function() onPressDefaultButton;
  const ErrorAppWidget({
    super.key,
    required this.description,
    required this.onPressDefaultButton,
    this.alternativeButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 100, color: Colors.red),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              textAlign: TextAlign.center,
              description,
              style: GlobalHelper.getTextStyle(
                context,
                appTextStyle: AppTextStyle.HEADLINE_SMALL,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          alternativeButton ??
              ((description.contains('401') ||
                      description.toLowerCase().contains('unauthenticated'))
                  ? FilledButton(
                    onPressed: () async {
                      await SharedPreferencesHelper.logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );          
                    },
                    child: Text('Logout'),
                  )
                  : FilledButton.icon(
                    onPressed: onPressDefaultButton,
                    icon: Icon(Icons.refresh),
                    label: Text(
                      "Refresh",
                      style: GlobalHelper.getTextStyle(
                        context,
                        appTextStyle: AppTextStyle.BODY_LARGE,
                      )?.copyWith(color: Colors.white),
                    ),
                  )),
        ],
      ),
    );
  }
}
