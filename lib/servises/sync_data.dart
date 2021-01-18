import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:time_tracking/localization/locate_constant.dart';
import 'package:time_tracking/providers/main_provider.dart';
import 'package:time_tracking/servises/settings.dart';
import 'package:time_tracking/servises/ext_stor.dart';
import 'package:time_tracking/servises/common.dart';

Future<Map<String, dynamic>> getContractors(String devId) async {
  // final String baseUrl =
  //     "http://10.91.130.204/test_maznov/hs/worktimerecording";
  final String baseUrl = await getServer1C();
  Map<String, dynamic> _request = {
    'result': 'serverErorr',
    'data': '',
  };
  try {
    final _contractorRequest = await http
        .get('$baseUrl/getContractors?id=$devId', headers: {
      'Content-Type': 'application/json'
    }).timeout(Duration(seconds: 10));
    if (_contractorRequest != null && _contractorRequest.statusCode == 200) {
      _request['result'] = 'ok';
      _request['data'] = json.decode(utf8.decode(_contractorRequest.bodyBytes));
    }
  } on TimeoutException catch (_) {
    _request['result'] = 'timeOut';
  } catch (e) {
    _request['result'] = 'serverErorr';
  }

  return _request;
}

Future<Map<String, dynamic>> sendWorkerData(
    String barcode, String _devId, String type, String photo) async {
  if (photo == null) {
    photo = '';
  }

  // final String baseUrl =
  //     "http://10.91.130.204/test_maznov/hs/worktimerecording";
  final String baseUrl = await getServer1C();
  Map<String, dynamic> _requestData;
  String _lcode = await getLanguageCode();
  String _barcode = '';
  if (barcode.trim().substring(0, 3) == '+++') {
    _barcode = barcode;
  } else {
    _barcode = '+++' + barcode.trim();
  }

  try {
    final _dataWorkerRequest =
        await http.post(baseUrl + '/makeRecord', headers: {
      'id': _devId,
      'type': type,
      'barcode': _barcode,
      'photo': photo,
      'language': _lcode,
    }).timeout(Duration(seconds: 10));
    if (_dataWorkerRequest.statusCode == 200) {
      _requestData = json.decode(utf8.decode(_dataWorkerRequest.bodyBytes));
    }
  } on Exception catch (e) {
    print(e);
  }

  return _requestData;
}

Future<String> sendContractorData(BuildContext context) async {
  // final String baseUrl =
  //     "http://10.91.130.204/test_maznov/hs/worktimerecording";
  final String baseUrl = await getServer1C();
  Map<String, dynamic> _requestData;
  String _errorMsg;
  String _lcode = await getLanguageCode();

  try {
    final _currProvider = Provider.of<MainProvider>(context, listen: false);
    String _barcode = '';
    if (_currProvider.workerCode.trim().substring(0, 3) == '+++') {
      _barcode = _currProvider.workerCode;
    } else {
      _barcode = '+++' + _currProvider.workerCode.trim();
    }
    final _dataWorkerRequest =
        await http.post(baseUrl + '/makeRecordContractors', headers: {
      'id': _currProvider.devId,
      'type': _currProvider.typeTime,
      'contractorId': _currProvider.currentContractor,
      'count': _currProvider.workerCount,
      'barcode': _barcode,
      'language': _lcode,
    }).timeout(Duration(seconds: 15));
    if (_dataWorkerRequest.statusCode == 200) {
      _requestData = json.decode(utf8.decode(_dataWorkerRequest.bodyBytes));
      if (_requestData['success'] == 'false') {
        _errorMsg = _requestData['error'].text;
      } else {
        _errorMsg = _requestData['message'];
      }
    }
  } on Exception catch (e) {
    print(e);
  }
  return _errorMsg;
}

Future<Map<String, dynamic>> checkIsForeman(
    String barcode, String _devId) async {
  // final String baseUrl =
  //     "http://10.91.130.204/test_maznov/hs/worktimerecording";
  final String baseUrl = await getServer1C();
  Map<String, dynamic> _requestData;
  String _lcode = await getLanguageCode();
  String _barcode = '';
  if (barcode.trim().substring(0, 3) == '+++') {
    _barcode = barcode;
  } else {
    _barcode = '+++' + barcode.trim();
  }

  try {
    final _dataWorkerRequest = await http.get(baseUrl + '/isForeman', headers: {
      'id': _devId,
      'barcode': _barcode,
      'language': _lcode,
    }).timeout(Duration(seconds: 10));
    if (_dataWorkerRequest.statusCode == 200) {
      _requestData = json.decode(utf8.decode(_dataWorkerRequest.bodyBytes));
    }
  } on Exception catch (e) {
    print(e);
  }

  return _requestData;
}

void sendPhoto(String _photoId) async {
  final _token = await getTokenExternalStor();
  await sendPhotoExternalStor(_token['token'], _photoId, _token['storPath']);
}

Future<String> getPhoto(String _photoId) async {
  final _token = await getTokenExternalStor();
  await getPhotoExternalStor(_photoId, _token['token'], _token['storPath']);
  String _tempFileName = await getFilePath(_photoId);
  return _tempFileName;
}

Future<bool> syncData(BuildContext context) async {
  String _devId = '';
  _devId = await getId();
  print(_devId);
  context.read<MainProvider>().changeDevId(_devId);

  final _storageToken = await getTokenExternalStor();
  final _requestData = await getContractors(_devId);
  if (_requestData['result'] == 'serverErorr' ||
      _requestData['result'] == 'timeOut' ||
      _storageToken['token'] == '' ||
      _requestData['data']['success'] == 'false') {
    context.read<MainProvider>().changeDeviceRegister(false);
    if (_requestData['result'] == 'serverErorr' ||
        _requestData['result'] == 'timeOut') {
      context.read<MainProvider>().changeErrorSettings(true);
    } else {
      context.read<MainProvider>().changeErrorSettings(false);
    }

    if (_storageToken['token'] == '') {
      context.read<MainProvider>().changeErrorSettingsStorage(true);
    } else {
      context.read<MainProvider>().changeErrorSettingsStorage(false);
    }
    return false;
  } else {
    context.read<MainProvider>().changeErrorSettings(false);
    context.read<MainProvider>().changeErrorSettingsStorage(false);
    context.read<MainProvider>().changeDeviceRegister(true);
    context
        .read<MainProvider>()
        .changeContractorsList(_requestData['data']['data']);
  }
  return true;
}
