import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scalex_chatbot/models/user_model.dart';
import 'package:scalex_chatbot/screens/auth/login_screen.dart';
import 'package:scalex_chatbot/services/user_provider.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/widgets/Error_popup.dart';
import 'package:scalex_chatbot/widgets/button_widget.dart';
import 'package:scalex_chatbot/widgets/language_toggel.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';
import 'package:scalex_chatbot/widgets/yes_or_no_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
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
                logout,
                redColor,
                false,
                lightColor,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout() async {
    showDialog(
      context: context,
      builder: (context) => YesOrNoPopup(
        AppLocalizations.of(context)!.common_alert,
        AppLocalizations.of(context)!.logout_confirmation,
        () async {
          setState(() => isLoading = true);
          try {
            await auth.signOut();
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.remove('user');
            if (!context.mounted) return;
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeName,
              (Route<dynamic> route) => false,
            );
          } catch (e) {
            setState(() => isLoading = false);
            showDialog(
              context: context,
              builder: (context) => ErrorPopup(
                AppLocalizations.of(context)!.common_alert,
                e.toString(),
              ),
            );
          } finally {
            if (mounted) setState(() => isLoading = false);
          }
        },
      ),
    );
  }
}
