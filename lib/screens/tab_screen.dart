import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';
import 'package:scalex_chatbot/screens/history_screen.dart';
import 'package:scalex_chatbot/screens/profile_screen.dart';
import 'package:scalex_chatbot/screens/summary_screen.dart';
import 'package:scalex_chatbot/utils/colors.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  static const routeName = "/TabScreen";

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int currentIndex = 0;
  late List<Widget> children;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    children = [HistoryScreen(), SummaryScreen(), ProfileScreen()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: Stack(
        children: [IndexedStack(index: currentIndex, children: children)],
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: lightColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: darkColor.withValues(alpha: 0.1),
                ),
              ],
            ),
            child: GNav(
              tabBorderRadius: 12.r,
              activeColor: primaryColor,
              tabBackgroundColor: primaryColor,
              padding: EdgeInsets.all(10),
              iconSize: 22.sp,
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              gap: 8,
              tabs: [
                GButton(
                  icon: FontAwesomeIcons.list,
                  text: AppLocalizations.of(context)!.tab_history,
                  iconColor: primaryColor,
                  iconActiveColor: lightColor,
                  textColor: lightColor,
                ),
                GButton(
                  icon: FontAwesomeIcons.clipboardList,
                  text: AppLocalizations.of(context)!.tab_summary,
                  iconColor: primaryColor,
                  iconActiveColor: lightColor,
                  textColor: lightColor,
                ),
                GButton(
                  icon: FontAwesomeIcons.user,
                  text: AppLocalizations.of(context)!.tab_profile,
                  iconColor: primaryColor,
                  iconActiveColor: lightColor,
                  textColor: lightColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
