import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:time_tracking/servises/settings.dart';

Future<Map<String, String>> getTokenExternalStor() async {
  Map<String, String> _res = {
    'error': '',
    'token': '',
    'storPath': '',
  };

  //final String baseUrl = 'http://10.91.133.154:6007/auth/v1.0/';

  final String baseUrl = await getStorage();
  final String login = await getStorageLogin();
  final String password = await getStoragePassword();
  final String url = baseUrl + '/auth/v1.0';

  try {
    final _dataRequest = await http.get(
      url,
      headers: {
        'X-Auth-User': login,
        'X-Auth-Key': password,
      },
    ).timeout(Duration(seconds: 5));
    if (_dataRequest.statusCode == 200) {
      _res['token'] = _dataRequest.headers['x-auth-token'];
      _res['storPath'] = _dataRequest.headers['x-storage-url'];
    }
  } on TimeoutException catch (e) {
    print(e);
    return _res;
  } catch (e) {
    print(e);
  }

  return _res;
}

Future<String> getPhotoExternalStor(
    String photoId, String token, String pathStor) async {
  Uint8List _dataPhoto;
  String _containerName = await getStorageContainer();
  final String baseUrl = pathStor + '/' + _containerName + '/';
  final String url = baseUrl + photoId;

  try {
    final _dataRequest = await http.get(
      url,
      headers: {
        'X-Auth-Token': token,
      },
    );
    if (_dataRequest.statusCode == 200) {
      _dataPhoto = _dataRequest.bodyBytes;
    }
  } on Exception catch (e) {
    print(e);
  }

  String _tempFileName = await getFilePath(photoId);
  File(_tempFileName).writeAsBytes(_dataPhoto);

  return _tempFileName;
}

Future<String> getFilePath(String _uuid) async {
  Directory _tempDir = await getExternalStorageDirectory();
  return _tempDir.path + '/' + _uuid + '.jpg';
}

Future<String> sendPhotoExternalStor(
    String token, String _photoId, String pathStor) async {
  String _request = '';

  Directory _tempDir = await getTemporaryDirectory();
  String _containerName = await getStorageContainer();
  final String baseUrl = pathStor + '/' + _containerName + '/';
  final String url = baseUrl + _photoId;

  try {
    final _dataRequest = await http.put(
      url,
      headers: {
        'X-Auth-Token': token,
        'Content-Type': 'image/jpeg',
      },
      body: File(_tempDir.path + '/photo_.jpg').readAsBytesSync(),
    );

    if (_dataRequest.statusCode == 201) {
      _request = _photoId;
    }
  } on Exception catch (e) {
    print(e);
  }
  print('photo sended to ext stor - ' + _request);
  return _request;
}
