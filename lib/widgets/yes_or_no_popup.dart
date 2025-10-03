import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';
import 'package:scalex_chatbot/widgets/button_widget.dart';

class YesOrNoPopup extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;
  final bool isLoading;

  const YesOrNoPopup(
    this.title,
    this.description,
    this.onPressed, {
    super.key,
    this.isLoading = false,
  });

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
        description,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      actions: <Widget>[
        ButtonWidget(
          AppLocalizations.of(context)!.common_no,
          () {
            Navigator.of(context).pop();
          },
          dSilverColor,
          true,
          textColor,
        ),
        SizedBox(width: 10.w),
        ButtonWidget(
          AppLocalizations.of(context)!.common_yes,
          onPressed,
          primaryColor,
          false,
          lightColor,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
