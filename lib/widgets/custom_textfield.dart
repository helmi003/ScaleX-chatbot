import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scalex_chatbot/utils/colors.dart';

class CustomTextfield extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextInputType type;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;

  const CustomTextfield(
    this.label,
    this.icon,
    this.type,
    this.controller,
    this.validator,
    this.autovalidateMode, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            label,
            style: TextStyle(
              color: darkColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          autovalidateMode: autovalidateMode,
          keyboardType: type,
          cursorColor: darkColor,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            errorStyle: TextStyle(color: redColor, fontSize: 8.sp),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: dSilverColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: dSilverColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: redColor),
            ),
            hintText: label,
            hintStyle: TextStyle(color: dSilverColor, fontSize: 10.sp),
            suffixIcon: Icon(icon, color: dSilverColor, size: 10.sp),
          ),
          style: TextStyle(color: darkColor, fontSize: 10.sp),
        ),
      ],
    );
  }
}
