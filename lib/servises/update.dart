import 'package:package_info/package_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml/xml.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:time_tracking/servises/common.dart';
import 'package:time_tracking/servises/settings.dart';

Future<String> checkUpdate() async {
  String result = '';
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String versionName = packageInfo.version;
  String _devId = await getId();
  final String _server1C = await getServer1C();
  final _server1CMap = _server1C.split('/');
  //"http://10.91.130.204/test_maznov/hs/worktimerecording";
  final _adressUpd =
      '${_server1CMap[0]}//${_server1CMap[2]}/${_server1CMap[3]}/ws/tsd.ws';

  String soap = '''<?xml version="1.0"?>
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:loc="http://localhost">
   <soapenv:Header/>
   <soapenv:Body>
      <loc:request_update>
         <loc:serial_no>$_devId</loc:serial_no>
         <loc:version>$versionName</loc:version>
      </loc:request_update>
   </soapenv:Body>
</soapenv:Envelope>''';
  String username = 'MobKPK';
  String password = 'tsd123';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  try {
    final response = await http.post(
      _adressUpd,
      headers: {
        "Content-Type": "application/xml",
        "Authorization": basicAuth,
      },
      body: utf8.encode(soap),
    );
    print(response.statusCode);
    final document = XmlDocument.parse(response.body);
    final returns = document
        .getElement('soap:Envelope')
        .getElement('soap:Body')
        .getElement('m:request_updateResponse')
        .getElement('m:return');
    print(returns.getElement('result_code').text);
    final data = returns.getElement('result_data').text;
    Directory _tempDir = await getExternalStorageDirectory();
    String _dataFile = data.replaceAll('\r', '').replaceAll('\n', '');
    File(_tempDir.path + '/update.apk').writeAsBytes(base64.decode(_dataFile));
    OpenFile.open(_tempDir.path + '/update.apk');
  } on SocketException catch (e) {
    result = e.toString();
  } catch (e) {
    result = e.toString();
  }
  return result;
}
