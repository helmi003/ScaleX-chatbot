import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';

class ChatBottomBar extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final ValueChanged<String> sendMessage;
  final VoidCallback cancelRequest;
  const ChatBottomBar(
    this.controller,
    this.isLoading,
    this.sendMessage,
    this.cancelRequest, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.common_typing,
                filled: true,
                fillColor: lightColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: const BorderSide(color: dSilverColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: const BorderSide(color: dSilverColor),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(isLoading ? FontAwesomeIcons.xmark : Icons.send),
            iconSize: 30.sp,
            color: isLoading ? darkColor : primaryColor,
            onPressed: () =>
                isLoading ? cancelRequest() : sendMessage(controller.text),
          ),
        ],
      ),
    );
  }
}
