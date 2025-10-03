import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scalex_chatbot/utils/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;
  final bool transparent;
  final Color textColor;
  final bool isLoading;
  const ButtonWidget(
    this.title,
    this.onPressed,
    this.color,
    this.transparent,
    this.textColor, {
    super.key,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          isLoading ? grayColor : (transparent ? Colors.transparent : color),
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        ),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: BorderSide(color: isLoading ? grayColor : color, width: 2.w),
          ),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 12.h,
              width: 12.h,
              child: CircularProgressIndicator(
                color: textColor,
                strokeWidth: 2.w,
              ),
            )
          : Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
    );
  }
}
