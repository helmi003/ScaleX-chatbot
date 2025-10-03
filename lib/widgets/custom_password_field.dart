import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scalex_chatbot/utils/colors.dart';

class CustomPasswordField extends StatelessWidget {
  final String label;
  final bool obsecure;
  final TextEditingController controller;
  final VoidCallback setObsecure;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;

  const CustomPasswordField(
    this.label,
    this.obsecure,
    this.controller,
    this.setObsecure,
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
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          autovalidateMode: autovalidateMode,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: textColor,
          controller: controller,
          validator: validator,
          obscureText: obsecure,
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
            hintStyle: TextStyle(color: dSilverColor, fontSize: 14.sp),
            suffixIcon: IconButton(
              onPressed: setObsecure,
              icon: Icon(
                obsecure ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                color: textColor,
                size: 14.sp,
              ),
            ),
          ),
          style: TextStyle(color: darkColor, fontSize: 14.sp),
        ),
      ],
    );
  }
}
