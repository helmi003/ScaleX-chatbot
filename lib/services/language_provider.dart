import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scalex_chatbot/models/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  final url = dotenv.env['API_URL'];
  Locale selectedLanguage = const Locale('en');

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('defaultLanguage');
    if (code != null) {
      selectedLanguage = LanguageModel.stringToLocale(code);
      notifyListeners();
    }
  }

  Future<void> setLanguage(Locale language) async {
    selectedLanguage = language;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('defaultLanguage', selectedLanguage.languageCode);
    notifyListeners();
  }

  bool checkSelectedLanguage(Locale language) {
    return selectedLanguage == language;
  }
}
