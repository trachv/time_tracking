import 'package:flutter/material.dart';
import 'package:time_tracking/models/language_data.dart';
import 'package:time_tracking/models/models_data.dart';

class MainProvider extends ChangeNotifier {
  LanguageData _locale;

  LanguageData get locale => _locale;
  void changeLocale(LanguageData valueLocale) {
    _locale = valueLocale;
    notifyListeners();
  }

  String _workerCode = '';
  String get workerCode => _workerCode;
  void changeWorkerCode(String val) {
    _workerCode = val;
    notifyListeners();
  }

  String _currentPhotoId = '';
  String get currentPhotoId => _currentPhotoId;
  void changeCurrentPhotoId(String val) {
    _currentPhotoId = val;
    notifyListeners();
  }

  String _typeTime = '';
  String get typeTime => _typeTime;
  void changeTypeTime(String _val) {
    _typeTime = _val;
  }

  String _devId = '';
  String get devId => _devId;
  void changeDevId(String val) {
    _devId = val;
  }

  bool _deviceRegister = false;
  bool get deviceRegister => _deviceRegister;
  void changeDeviceRegister(bool val) {
    _deviceRegister = val;
    notifyListeners();
  }

  Worker _currentWorker;
  Worker get currentWorker => _currentWorker;
  void changeCurrentWorker(Worker currW) {
    _currentWorker = currW;
  }

  List<dynamic> _contractorsList = [];
  List<dynamic> get contractorsList => _contractorsList;
  void changeContractorsList(List<dynamic> _cList) {
    _contractorsList = _cList;
    notifyListeners();
  }

  void changeWorkerCodeAdd(int valueWorkerCode) {
    int _locVal;
    if (valueWorkerCode == 10) {
      _locVal = 0;
    } else if (valueWorkerCode != 11) {
      _locVal = valueWorkerCode + 1;
    }

    if (_workerCode.length < 13) {
      _workerCode = _workerCode + _locVal.toString();
    }

    notifyListeners();
  }

  void changeWorkerCodeDelete() {
    if (_workerCode.length >= 1) {
      _workerCode = _workerCode.substring(0, _workerCode.length - 1);
    }
    notifyListeners();
  }

  String _workerCount = '';
  String get workerCount => _workerCount;
  void changeWorkerCountAdd(int valueWorkerCount) {
    int _locVal;
    if (valueWorkerCount == 10) {
      _locVal = 0;
    } else if (valueWorkerCount != 11) {
      _locVal = valueWorkerCount + 1;
    }

    if (_workerCount.length < 3) {
      _workerCount = _workerCount + _locVal.toString();
    }

    notifyListeners();
  }

  void changeWorkerCountDelete() {
    if (_workerCount.length >= 1) {
      _workerCount = _workerCount.substring(0, _workerCount.length - 1);
    }
    notifyListeners();
  }

  void changeWorkerCountClear() {
    _workerCount = '';
    notifyListeners();
  }

  void cleanGoHome() {
    _workerCode = '';
    _workerCount = '';
    _currentContractor = '';
  }

  String _currentContractor = '';
  String get currentContractor => _currentContractor;
  void changecurrentContractor(String _currentValue) {
    _currentContractor = _currentValue;
    notifyListeners();
  }

  String _currentContractorName = '';
  String get currentContractorName => _currentContractorName;
  void changecurrentContractorName(String _currentValue) {
    _currentContractorName = _currentValue;
    notifyListeners();
  }

  String _adressServer1C = '';
  String get adressServer1C => _adressServer1C;
  void changeAdressServer1C(String _currentValue) {
    _adressServer1C = _currentValue;
    notifyListeners();
  }

  String _adressStorage = '';
  String get adressStorage => _adressStorage;
  void changeAdressStorage(String _currentValue) {
    _adressStorage = _currentValue;
    notifyListeners();
  }

  String _loginStorage = '';
  String get loginStorage => _loginStorage;
  void changeLoginStorage(String _currentValue) {
    _loginStorage = _currentValue;
    notifyListeners();
  }

  String _passwordStorage = '';
  String get passwordStorage => _passwordStorage;
  void changePasswordStorage(String _currentValue) {
    _passwordStorage = _currentValue;
    notifyListeners();
  }

  String _containerStorage = '';
  String get containerStorage => _containerStorage;
  void changeContainerStorage(String _currentValue) {
    _containerStorage = _currentValue;
    notifyListeners();
  }

  bool _errorSettings = false;
  bool get errorSettings => _errorSettings;
  void changeErrorSettings(bool _currentValue) {
    _errorSettings = _currentValue;
    notifyListeners();
  }

  bool _errorSettingsStorage = false;
  bool get errorSettingsStorage => _errorSettingsStorage;
  void changeErrorSettingsStorage(bool _currentValue) {
    _errorSettingsStorage = _currentValue;
    notifyListeners();
  }
}
