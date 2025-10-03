import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scalex_chatbot/models/user_model.dart';
import 'package:scalex_chatbot/services/user_provider.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/widgets/button_widget.dart';
import 'package:scalex_chatbot/widgets/language_toggel.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        title: Text(
          AppLocalizations.of(context)!.tab_profile,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: lightColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(
                  context,
                )!.welcome_back_user('${user.firstName} ${user.lastName}'),
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10.h),
              LanguageToggle(),
              SizedBox(height: 10.h),
              ButtonWidget(
                AppLocalizations.of(context)!.common_log_out,
                () {},
                redColor,
                false,
                lightColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
