import 'package:flutter/material.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get buttonTimeStart;

  String get buttonTimeFinish;

  String get buttonContractors;

  String get buttonScan;

  String get codeHint;

  String get codeTitle;

  String get conpanyListTitle;

  String get buttonCompliteTitle;

  String get workerCountHint;

  String get worker;

  String get scanError;

  String get repeateEnterCode;

  String get errorNotRegister;

  String get errorExtStor;

  String get errorServer1c;

  String get adressServer1c;

  String get adressExtStor;

  String get loginExtStor;

  String get passExtStor;

  String get containerExtStor;

  String get inputHandle;

  String get authAndClose;

  String get loadingPhoto;

  String get timeOk;

  String get goHome;
}
