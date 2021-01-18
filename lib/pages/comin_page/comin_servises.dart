import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:time_tracking/providers/main_provider.dart';
import 'package:time_tracking/models/models_data.dart';
import 'package:time_tracking/servises/sync_data.dart';
import 'package:time_tracking/pages/comin_page/comin_dialog.dart';
import 'package:uuid/uuid.dart';

processBarcode(BuildContext _context, [bool inputScan]) {
  if (Provider.of<MainProvider>(_context, listen: false).typeTime == '3') {
    processContractor(_context, inputScan);
  } else {
    processWorker(_context, inputScan);
  }
}

processContractor(BuildContext _context, bool inputScan) async {
  Map<String, dynamic> _requestData = await checkIsForeman(
      Provider.of<MainProvider>(_context, listen: false).workerCode,
      Provider.of<MainProvider>(_context, listen: false).devId);
  print(_requestData);
  if (_requestData['success'] == 'false') {
    if (inputScan) {
      Navigator.of(_context).pop();
    }
    // Navigator.pushNamedAndRemoveUntil(
    //     _context, '/cominPage', (Route<dynamic> route) => false);
    showErrorPopup(_context);
  } else {
    Navigator.pushNamedAndRemoveUntil(
        _context, '/inoutPage', (Route<dynamic> route) => false);
  }
}

processWorker(BuildContext _context, bool inputScan) async {
  String _photoId = Uuid().v1();
  _context.read<MainProvider>().changeCurrentPhotoId(_photoId);

  Map<String, dynamic> _requestData = await sendWorkerData(
      Provider.of<MainProvider>(_context, listen: false).workerCode,
      Provider.of<MainProvider>(_context, listen: false).devId,
      Provider.of<MainProvider>(_context, listen: false).typeTime,
      _photoId);

  if (_requestData['success'] == 'false') {
    if (inputScan) {
      Navigator.of(_context).pop();
    }
    // Navigator.pushNamedAndRemoveUntil(
    //     _context, '/cominPage', (Route<dynamic> route) => false);
    showErrorPopup(_context);
  } else {
    Worker _worker = Worker.fromMap(_requestData);
    _context.read<MainProvider>().changeCurrentWorker(_worker);
    Navigator.of(_context).pushNamed('/infoworkerPage');
  }
  _context.read<MainProvider>().changeWorkerCode('');
}
