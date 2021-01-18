import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:time_tracking/main.dart';
import 'package:time_tracking/models/language_data.dart';
import 'package:time_tracking/providers/main_provider.dart';
import 'package:provider/provider.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";

Future<String> getLanguageCode() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "uk";
  if (languageCode == 'uk') {
    languageCode = 'ua';
  }

  return languageCode;
}

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "uk";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : Locale('uk', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var _locale = await setLocale(selectedLanguageCode);
  context
      .read<MainProvider>()
      .changeLocale(LanguageData.languageData(selectedLanguageCode));
  TimeTrackingApp.setLocale(context, _locale);
}
