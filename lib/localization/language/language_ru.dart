import 'languages.dart';

class LanguageRu extends Languages {
  @override
  String get appName => "SAT: Учет рабочего времени";

  @override
  String get buttonTimeStart => "Отметить время прихода";

  @override
  String get buttonTimeFinish => "Отметить время ухода";

  @override
  String get buttonContractors => "Подрядчики";

  @override
  String get buttonScan => "СКАНИРОВАТЬ";

  @override
  String get codeHint => "Введите номер";

  @override
  String get codeTitle => "Сканируйте код";

  @override
  String get conpanyListTitle => "Веберите компанию";

  @override
  String get buttonCompliteTitle => "Подтвердить";

  @override
  String get workerCountHint => "Количество";

  @override
  String get worker => "Сотрудников";

  @override
  String get scanError => "Сотрудник не найден";

  @override
  String get repeateEnterCode => "Ввести код"; 

  @override
  String get errorNotRegister => "Устройство не зарегистрировано в системе. Обратитесь к администратору. ID устройства: ";

  @override
  String get errorExtStor => "Ошибка: Внешнее хранилище не доступно";

  @override
  String get errorServer1c => "Ошибка: Сервер 1С не доступен";

  @override
  String get adressServer1c => "Адрес сервера 1С"; 

  @override
  String get adressExtStor => "Адрес внешнего хранилища"; 

  @override
  String get loginExtStor => "Пользователь внешнего хранилища"; 

  @override
  String get passExtStor => "Пароль пользователя внешнего хранилища"; 

  @override
  String get containerExtStor => "Название контейнера внешнего хранилища"; 

  @override
  String get inputHandle => "Ввести вручную"; 

  @override
  String get authAndClose => "Авторизоваться и закрыть"; 

  @override
  String get loadingPhoto => "Загрузка фото"; 

  @override
  String get timeOk => "Время зафиксированно"; 

  @override
  String get goHome => "На главную"; 
}
