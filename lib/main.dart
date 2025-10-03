import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:scalex_chatbot/l10n/l10n.dart';
import 'package:scalex_chatbot/models/chat_message_model.dart';
import 'package:scalex_chatbot/models/chat_room_model.dart';
import 'package:scalex_chatbot/screens/chat_screen.dart';
import 'package:scalex_chatbot/screens/auth/login_screen.dart';
import 'package:scalex_chatbot/screens/auth/register_screen.dart';
import 'package:scalex_chatbot/screens/splash_screen.dart';
import 'package:scalex_chatbot/screens/tab_screen.dart';
import 'package:scalex_chatbot/services/chat_provider.dart';
import 'package:scalex_chatbot/services/language_provider.dart';
import 'package:scalex_chatbot/services/user_provider.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();

  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(ChatRoomAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final selectedLocale = context.watch<LanguageProvider>().selectedLanguage;
    return ScreenUtilInit(
      designSize: const Size(396, 642),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: MaterialApp(
            title: 'Scalex ChatBot',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Inter'),
            home: SplashScreen(),
            routes: {
              TabScreen.routeName: (context) => TabScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
              RegisterScreen.routeName: (context) => RegisterScreen(),
              ChatScreen.routeName: (context) => ChatScreen(),
            },
            supportedLocales: L10n.all,
            locale: selectedLocale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        );
      },
    );
  }
}
