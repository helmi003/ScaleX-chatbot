import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/widgets/button_widget.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';
import 'package:scalex_chatbot/widgets/custom_textfield.dart';

class EditMessage extends StatelessWidget {
  final String title;
  final String description;
  final TextEditingController editController;
  final VoidCallback onPressed;
  final bool isLoading;

  const EditMessage(
    this.title,
    this.description,
    this.editController,
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
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            description,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          SizedBox(height: 5.h),
          CustomTextfield(
            AppLocalizations.of(context)!.common_message,
            FontAwesomeIcons.message,
            TextInputType.text,
            editController,
            (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.common_required;
              }
              return null;
            },
            AutovalidateMode.onUserInteraction,
          ),
        ],
      ),
      actions: <Widget>[
        ButtonWidget(
          AppLocalizations.of(context)!.common_cancel,
          () {
            Navigator.of(context).pop();
          },
          dSilverColor,
          true,
          textColor,
        ),
        SizedBox(width: 10.w),
        ButtonWidget(
          AppLocalizations.of(context)!.common_save,
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
