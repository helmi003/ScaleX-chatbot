import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scalex_chatbot/data/language_data.dart';
import 'package:scalex_chatbot/services/language_provider.dart';
import 'package:scalex_chatbot/utils/colors.dart';

class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final selectedLang = languageProvider.selectedLanguage;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildOption(0, selectedLang, languageProvider),
                buildOption(1, selectedLang, languageProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildOption(
    int index,
    Locale selectedLang,
    LanguageProvider languageProvider,
  ) {
    final lang = languages[index];
    final isActive = selectedLang == lang.code;

    return Expanded(
      child: GestureDetector(
        onTap: () => languageProvider.setLanguage(lang.code),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
          decoration: BoxDecoration(
            color: isActive
                ? primaryColor.withValues(alpha: 0.1)
                : Colors.white,
            border: Border.all(
              color: isActive ? primaryColor : dSilverColor,
              width: isActive ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.horizontal(
              left: index == 0 ? Radius.circular(12.r) : Radius.zero,
              right: index == 1 ? Radius.circular(12.r) : Radius.zero,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/lang/${lang.image}",
                height: 18.h,
                width: 18.h,
              ),
              SizedBox(width: 6.w),
              Text(
                lang.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? primaryColor : textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
