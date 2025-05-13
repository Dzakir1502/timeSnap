import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timesnap/app/presentation/face_recognition/face_recognition_notifier.dart';
import 'package:timesnap/app/presentation/map/map_page.dart';
import 'package:timesnap/core/helper/global_helper.dart';
import 'package:timesnap/core/widget/app_widget.dart';

class FaceRecognitionPage
    extends AppWidget<FaceRecognitionNotifier, void, void> {
  @override
  void checkVariableAfterUi(BuildContext context) {
    if (notifier.percentMatch >= 70) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MapPage()),
      );
    }
  }

  @override
  AppBar? appBarBuild(BuildContext context) {
    return AppBar(title: Text('Face validation'));
  }

  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (notifier.currentImage != null)
                ? Image(
                  width: 150,
                  height: 150,
                  image: notifier.currentImage!.image,
                )
                : Icon(Icons.no_photography, size: 75),
            SizedBox(height: 50),
            (notifier.currentImage == null)
                ? Text(
                  "Failed to take Photo",
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.HEADLINE_MEDIUM,
                  ),
                )
                : (notifier.percentMatch < 0.0)
                ? Text(
                  'You Have No Right To Make Attendance',
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.HEADLINE_SMALL,
                  ),
                  textAlign: TextAlign.center,
                )
                : Text(
                  'Similarity level : ${notifier.percentMatch}',
                  style: GlobalHelper.getTextStyle(
                    context,
                    appTextStyle: AppTextStyle.HEADLINE_MEDIUM,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25,),
            FilledButton(
              onPressed: _onPressOpenCamera,
              child: Text("Open Camera"),
            ),
          ],
        ),
      ),
    );
  }

  _onPressOpenCamera() {
    notifier.getCurrentPhoto();
  }
}
