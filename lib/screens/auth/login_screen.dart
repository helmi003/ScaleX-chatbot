import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scalex_chatbot/models/user_model.dart';
import 'package:scalex_chatbot/screens/auth/register_screen.dart';
import 'package:scalex_chatbot/screens/tab_screen.dart';
import 'package:scalex_chatbot/services/user_provider.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/widgets/error_popup.dart';
import 'package:scalex_chatbot/widgets/button_widget.dart';
import 'package:scalex_chatbot/widgets/custom_password_field.dart';
import 'package:scalex_chatbot/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';
import 'package:scalex_chatbot/widgets/language_toggel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool obsecure = true;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: lightColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.h),
                    Image.asset(
                      "assets/images/logo.png",
                      height: 130.h,
                      width: 130.h,
                    ),
                    LanguageToggle(),
                    Text(
                      AppLocalizations.of(context)!.login_description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        color: textColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      child: CustomTextfield(
                        AppLocalizations.of(context)!.common_upper_email,
                        FontAwesomeIcons.envelope,
                        TextInputType.emailAddress,
                        email,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.email_required;
                          } else if (!EmailValidator.validate(email.text)) {
                            return AppLocalizations.of(context)!.invalid_email;
                          }
                          return null;
                        },
                        AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomPasswordField(
                        AppLocalizations.of(context)!.common_password,
                        obsecure,
                        password,
                        () {
                          setState(() {
                            obsecure = !obsecure;
                          });
                        },
                        (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.common_required;
                          }
                          return null;
                        },
                        AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ButtonWidget(
                      AppLocalizations.of(context)!.common_login,
                      login,
                      primaryColor,
                      false,
                      lightColor,
                    ),
                    SizedBox(height: 20.h),
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.no_account,
                        style: TextStyle(color: textColor, fontSize: 10.sp),
                        children: [
                          TextSpan(
                            text:
                                " ${AppLocalizations.of(context)!.common_register}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RegisterScreen.routeName,
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        setState(() {
          isLoading = true;
        });
        await auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(auth.currentUser!.uid)
                .get();
        print("exists: ${userSnapshot.exists}");
        if (userSnapshot.exists) {
          final prefs = await SharedPreferences.getInstance();
          UserModel userData = UserModel.fromJson(userSnapshot.data()!);
          prefs.setString('user', json.encode(userData.toJson()));
          if (!mounted) return;
          Provider.of<UserProvider>(context, listen: false).setUser(userData);
          Navigator.pushNamedAndRemoveUntil(
            context,
            TabScreen.routeName,
            (Route<dynamic> route) => false,
          );
        } else {
          if (!mounted) return;
          showDialog(
            context: context,
            builder: ((context) {
              return ErrorPopup(
                AppLocalizations.of(context)!.common_alert,
                AppLocalizations.of(context)!.user_dont_exist,
              );
            }),
          );
        }
      } catch (onError) {
        print("error: $onError");
        showDialog(
          context: context,
          builder: ((context) {
            return ErrorPopup(
              AppLocalizations.of(context)!.common_alert,
              AppLocalizations.of(context)!.unknown_error,
            );
          }),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
