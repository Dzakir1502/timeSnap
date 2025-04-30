import 'package:flutter/material.dart';
import 'package:timesnap/core/helper/global_helper.dart';

class ErrorAppWidget extends StatelessWidget {
  final String description;
  final FilledButton? alternativeButton;
  final void Function() onPressDefault;
  const ErrorAppWidget({
    super.key,
    required this.description,
    required this.onPressDefault,
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
          Text(
            description,
            style: GlobalHelper.getTextStyle(
              context,
              appTextStyle: AppTextStyle.HEADLINE_SMALL,
            ),
          ),
          SizedBox(height: 30.0),
          alternativeButton ??
              FilledButton.icon(
                onPressed: onPressDefault,
                icon: Icon(Icons.refresh),
                label: Text("Refresh"),
              ),
        ],
      ),
    );
  }
}
