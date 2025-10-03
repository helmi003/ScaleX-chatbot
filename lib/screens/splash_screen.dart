import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scalex_chatbot/screens/auth/login_screen.dart';
import 'package:scalex_chatbot/screens/tab_screen.dart';
import 'package:scalex_chatbot/services/user_provider.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/widgets/error_popup.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.forward();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  bool isloggedin = false;

  Future<void> getUser() async {
    User? firebaseUser = auth.currentUser;
    await firebaseUser?.reload();
    if (!mounted) return;
    firebaseUser = auth.currentUser;

    if (firebaseUser != null) {
      if (!mounted) return;
      setState(() {
        user = firebaseUser!;
        isloggedin = true;
      });
    }
  }

  @override
  void initState() {
    getUser();
    Future.delayed(const Duration(seconds: 2), () async {
      try {
        if (!mounted) return;
        bool loggedIn = await context.read<UserProvider>().tryAutoLogin();
        if (isloggedin && loggedIn) {
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, TabScreen.routeName);
        } else {
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
      } catch (e) {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: ((context) {
            return ErrorPopup(
              AppLocalizations.of(context)!.common_alert,
              AppLocalizations.of(context)!.unknown_error,
            );
          }),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: ScaleTransition(
        scale: _animation,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30.w),
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
