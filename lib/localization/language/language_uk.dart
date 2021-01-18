import 'languages.dart';

class LanguageUk extends Languages {
  @override
  String get appName => "SAT: Облік робочого часу";

  @override
  String get buttonTimeStart => "Відмітити час приходу";

  @override
  String get buttonTimeFinish => "Відмітити час уходу";

  @override
  String get buttonContractors => "Підрядники";

  @override
  String get buttonScan => "СКАНУВАТИ";

  @override
  String get codeHint => "Введіть номер";

  @override
  String get conpanyListTitle => "Оберіть компанію";

  @override
  String get buttonCompliteTitle => "Підтвердити";

  @override
  String get workerCountHint => "Кількість";

  @override
  String get worker => "Співробітників";

  @override
  String get codeTitle => "Скануйте код";

  @override
  String get scanError => "Співробітника не знайдено";

   @override
  String get repeateEnterCode => "Ввести код"; 

   @override
  String get errorNotRegister => "Пристрій не зареєстровано в системі. Зверніться до адміністратора. ID пристрою: "; 

  @override
  String get errorExtStor => "Помилка: Зовнішнє сховище не доступне"; 

  @override
  String get errorServer1c => "Помилка: Сервер 1С не доступний"; 

  @override
  String get adressServer1c => "Адреса серверу 1С"; 

  @override
  String get adressExtStor => "Адреса зовнішнього сховища"; 

  @override
  String get loginExtStor => "Користувач зовнішнього сховища"; 

  @override
  String get passExtStor => "Пароль користувача зовнішнього сховища"; 

  @override
  String get containerExtStor => "Назва контейнеру зовнішнього сховища"; 

  @override
  String get inputHandle => "Ввести вручну"; 

  @override
  String get authAndClose => "Авторизуватися и закрити"; 

  @override
  String get loadingPhoto => "Завантаження фото"; 

  @override
  String get timeOk => "Час зафіксовано"; 

  @override
  String get goHome => "На головну"; 

}
