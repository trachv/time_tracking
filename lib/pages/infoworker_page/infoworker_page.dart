import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:time_tracking/providers/main_provider.dart';
import 'package:time_tracking/servises/ext_stor.dart';
import 'package:time_tracking/servises/settings.dart';
import 'package:time_tracking/widgets/app_bar.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:time_tracking/servises/sync_data.dart';
import 'package:time_tracking/models/models_data.dart';
import 'package:time_tracking/localization/language/languages.dart';

class InfoworkerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoworkerPage();
}

class _InfoworkerPage extends State<InfoworkerPage> {
  static const platform = MethodChannel('camera_activity');
  String _photoId;

  _makePhoto(BuildContext context) async {
    try {
      final String result = await platform.invokeMethod('startNewActivity');
      print(result);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    //platform.setMethodCallHandler(nativeMethodCallHandler);
    super.initState();
    print('init state infoworker page');
    _photoId = Provider.of<MainProvider>(context, listen: false).currentPhotoId;
    Timer(Duration(seconds: 3), () {
      print('run make photo');
      _makePhoto(context);
    });
    // Future.delayed(Duration(seconds: 3), () {
    //   _makePhoto(context);
    // });
    Timer(Duration(seconds: 10), () => sendPhoto(_photoId));
    // Future.delayed(Duration(seconds: 10), () {
    //   sendPhoto(_photoId);
    // });
    Timer(Duration(seconds: 11), () {
      final _currWorker =
          Provider.of<MainProvider>(context, listen: false).currentWorker;
      deleteFile(_currWorker.photoId);
      Navigator.pushNamedAndRemoveUntil(
          context, '/homePage', (Route<dynamic> route) => false);
    });
    // Future.delayed(Duration(seconds: 11), () {
    //   final _currWorker =
    //       Provider.of<MainProvider>(context, listen: false).currentWorker;
    //   deleteFile(_currWorker.photoId);
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, '/homePage', (Route<dynamic> route) => false);
    // });
  }

  // Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
  //   print('Native call!');
  //   switch (methodCall.method) {
  //     case "methodNameItz":
  //       sendPhoto(_photoId);
  //       Navigator.pushNamedAndRemoveUntil(
  //         context, '/homePage', (Route<dynamic> route) => false);
  //       return "This data from flutter.....";
  //       break;
  //     default:
  //       return "Nothing";
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: InfoworkerBody(),
    );
  }
}

deleteFile(String _photoId) async {
  String _tempFileName = await getFilePath(_photoId);
  await File(_tempFileName).delete();
}

class InfoworkerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Settings().height(context) * 0.02),
      child: Row(
        children: [
          Infoworker(),
          SizedBox(
            width: Settings().width(context) * 0.02,
          ),
          Infotime(),
        ],
      ),
    );
  }
}

class Infoworker extends StatelessWidget {
  Future _imageWorker(Worker _currWorker) async {
    if (_currWorker.photoId == '') {
      return Image(
        image: AssetImage('assets/images/empty-avatar.png'),
      );
    }
    String _tempFileName = await getPhoto(_currWorker.photoId);
    return Image(image: FileImage(File(_tempFileName)));
  }

  @override
  Widget build(BuildContext context) {
    final _currWorker =
        Provider.of<MainProvider>(context, listen: false).currentWorker;
    return Container(
      color: Theme.of(context).primaryColor,
      width: Settings().width(context) * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Settings().width(context) * 0.3,
            height: Settings().height(context) * 0.6,
            child: FutureBuilder(
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.done) {
                  return projectSnap.data;
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text(Languages.of(context).loadingPhoto),
                  ],
                );
              },
              future: _imageWorker(_currWorker),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              _currWorker.fio,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  _currWorker.position,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Infotime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _hour = DateTime.now().hour.toString().padLeft(2, '0');
    String _minute = DateTime.now().minute.toString().padLeft(2, '0');

    return Expanded(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Languages.of(context).timeOk,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              _hour + ':' + _minute,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}
