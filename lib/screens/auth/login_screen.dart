import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scalex_chatbot/screens/auth/register_screen.dart';
import 'package:scalex_chatbot/screens/tab_screen.dart';
import 'package:scalex_chatbot/services/user_provider.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/widgets/button_widget.dart';
import 'package:scalex_chatbot/widgets/custom_password_field.dart';
import 'package:scalex_chatbot/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';
import 'package:scalex_chatbot/widgets/language_toggel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obsecure = true;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: lightColor,
          body: Center(
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
                    SizedBox(height: 20.h),
                    Text(
                      AppLocalizations.of(context)!.login_description,
                      style: TextStyle(
                        fontSize: 16.sp,
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
                      isLoading: isLoading,
                    ),
                    SizedBox(height: 20.h),
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.no_account,
                        style: TextStyle(color: textColor, fontSize: 14.sp),
                        children: [
                          TextSpan(
                            text:
                                " ${AppLocalizations.of(context)!.common_register}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
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
                    SizedBox(height: 20.h),
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
    if (!(formKey.currentState?.validate() ?? false)) return;
    setState(() => isLoading = true);

    await Provider.of<UserProvider>(context, listen: false).login(
      email: email.text,
      password: password.text,
      context: context,
      onSuccess: (userData) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          TabScreen.routeName,
          (Route<dynamic> route) => false,
        );
      },
    );

    if (mounted) setState(() => isLoading = false);
  }
}
