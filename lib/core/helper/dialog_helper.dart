import 'package:flutter/material.dart';
import 'package:timesnap/core/helper/global_helper.dart';

class DialogHelper {
  static showSnackBar({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  static showBottomDialog({
    required BuildContext context,
   
    required Widget content,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text('',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              content,
            ],
          ),
        );
      },
    );
  }

  static showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color(0xFFF0FAFF), // latar card (biru muda seperti contoh)
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF0D3B66), // warna icon background (biru tua)
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.check,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
               Text(
                "Your request has\nbeen successfully\nsubmitted!",
                textAlign: TextAlign.center,
                style:GlobalHelper.getTextStyle(context, appTextStyle: AppTextStyle.LABEL_MEDIUM)?.copyWith(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // close dialog
      Navigator.of(context).pop(); // kembali ke halaman sebelumnya
    });
  }

}
