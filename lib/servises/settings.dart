import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracking/providers/main_provider.dart';
import 'package:provider/provider.dart';

class Settings {
  double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

const String prefServer1C = "AdressServer1C";
const String prefStrorage = "AdressStorage";
const String prefStorageLogin = "LoginStorage";
const String prefStoragePassword = "PasswordStorage";
const String prefStorageContainer = "ContainerStorage";

Future<void> setServer1C(String adressServer1C) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefServer1C, adressServer1C);
}

Future<String> getServer1C() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String server1C = _prefs.getString(prefServer1C) ?? '';
  return server1C;
}

Future<void> setStorage(String adressStorage) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefStrorage, adressStorage);
}

Future<String> getStorage() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String storage = _prefs.getString(prefStrorage) ?? '';
  return storage;
}

Future<void> setStorageLogin(String loginStorage) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefStorageLogin, loginStorage);
}

Future<String> getStorageLogin() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String storageLogin = _prefs.getString(prefStorageLogin) ?? '';
  return storageLogin;
}

Future<void> setStoragePassword(String passwordStorage) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefStoragePassword, passwordStorage);
}

Future<String> getStoragePassword() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String storagePassword = _prefs.getString(prefStoragePassword) ?? '';
  return storagePassword;
}

Future<void> setStorageContainer(String containerStorage) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefStorageContainer, containerStorage);
}

Future<String> getStorageContainer() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String storageContainer = _prefs.getString(prefStorageContainer) ?? '';
  return storageContainer;
}

Future<void> initializePref(BuildContext context) async {
  String _prefServer1C = await getServer1C();
  context.read<MainProvider>().changeAdressServer1C(_prefServer1C);
  String _prefStorage = await getStorage();
  context.read<MainProvider>().changeAdressStorage(_prefStorage);

  String _prefStorageLogin = await getStorageLogin();
  context.read<MainProvider>().changeLoginStorage(_prefStorageLogin);
  String _prefStoragePassword = await getStoragePassword();
  context.read<MainProvider>().changePasswordStorage(_prefStoragePassword);
  String _prefStorageContainer = await getStorageContainer();
  context.read<MainProvider>().changeContainerStorage(_prefStorageContainer);
}
