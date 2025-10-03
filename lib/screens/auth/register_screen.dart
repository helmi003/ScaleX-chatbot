import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scalex_chatbot/screens/auth/login_screen.dart';
import 'package:scalex_chatbot/screens/tab_screen.dart';
import 'package:scalex_chatbot/services/user_provider.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/widgets/button_widget.dart';
import 'package:scalex_chatbot/widgets/custom_password_field.dart';
import 'package:scalex_chatbot/widgets/custom_textfield.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';
import 'package:scalex_chatbot/widgets/language_toggel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = "/RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
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
                      AppLocalizations.of(context)!.register_description,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomTextfield(
                        AppLocalizations.of(context)!.common_first_name,
                        FontAwesomeIcons.user,
                        TextInputType.name,
                        firstName,
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
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomTextfield(
                        AppLocalizations.of(context)!.common_last_name,
                        FontAwesomeIcons.user,
                        TextInputType.name,
                        lastName,
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
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    SizedBox(height: 10.h),
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
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomPasswordField(
                        AppLocalizations.of(context)!.common_confirm_password,
                        obsecure,
                        confirmPassword,
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
                          } else if (value != password.text) {
                            return AppLocalizations.of(
                              context,
                            )!.passwords_do_not_match;
                          }
                          return null;
                        },
                        AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ButtonWidget(
                      AppLocalizations.of(context)!.common_register,
                      register,
                      primaryColor,
                      false,
                      lightColor,
                      isLoading: isLoading,
                    ),
                    SizedBox(height: 20.h),
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.you_have_an_account,
                        style: TextStyle(color: textColor, fontSize: 14.sp),
                        children: [
                          TextSpan(
                            text:
                                " ${AppLocalizations.of(context)!.common_login}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  LoginScreen.routeName,
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

  Future<void> register() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    setState(() => isLoading = true);

    await Provider.of<UserProvider>(context, listen: false).register(
      email: email.text,
      password: password.text,
      firstName: firstName.text,
      lastName: lastName.text,
      context: context,
      onSuccess: (userModel) {
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
