class LanguageData {
  final String flag;
  final String name;
  final String languageCode;

  LanguageData(this.flag, this.name, this.languageCode);

  static LanguageData languageData(String languageCode) {
    if (languageCode == 'uk') {
      return LanguageData('UA', "Українська", 'uk');
    } else {
      return LanguageData("RU", "Русский", "ru");
    }
  }

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData('UA', "Українська", 'uk'),
      LanguageData("RU", "Русский", "ru"),
    ];
  }
}
