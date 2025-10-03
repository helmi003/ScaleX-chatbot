import 'package:flutter/material.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/widgets/button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';

class ErrorPopup extends StatelessWidget {
  final String title;
  final String errorMsg;
  const ErrorPopup(this.title, this.errorMsg, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: redColor,
          fontWeight: FontWeight.w800,
        ),
      ),
      content: Text(
        errorMsg,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      actions: <Widget>[
        ButtonWidget(
          AppLocalizations.of(context)!.common_ok,
          () {
            Navigator.of(context).pop();
          },
          primaryColor,
          false,
          lightColor,
        ),
      ],
    );
  }
}
