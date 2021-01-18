import 'package:flutter/material.dart';
import 'package:time_tracking/localization/language/language_uk.dart';
import 'package:time_tracking/localization/language/language_ru.dart';

import 'language/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ru', 'uk'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'uk':
        return LanguageUk();
      case 'ru':
        return LanguageRu();
      default:
        return LanguageUk();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
