import 'package:flutter/material.dart';

class LanguageModel {
  final Locale code;
  final String name;
  final String image;

  LanguageModel(this.code, this.name, this.image);

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      json['code'] ?? '',
      json['name'] ?? '',
      json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name, 'image': image};
  }

  static Locale stringToLocale(String code) {
    return Locale(code);
  }

  static String localeToString(Locale locale) {
    return locale.languageCode;
  }
}
