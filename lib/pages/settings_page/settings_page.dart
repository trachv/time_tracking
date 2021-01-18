import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:time_tracking/localization/language/languages.dart';
import 'package:time_tracking/servises/settings.dart';
import 'package:time_tracking/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking/providers/main_provider.dart';
import 'package:time_tracking/servises/sync_data.dart';
import 'package:flutter/services.dart';
import 'package:time_tracking/servises/update.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  final _controllerServer1C = TextEditingController();
  final _storageController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _containerController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controllerServer1C.text =
        Provider.of<MainProvider>(context, listen: false).adressServer1C;
    _storageController.text =
        Provider.of<MainProvider>(context, listen: false).adressStorage;

    _loginController.text =
        Provider.of<MainProvider>(context, listen: false).loginStorage;
    _passwordController.text =
        Provider.of<MainProvider>(context, listen: false).passwordStorage;
    _containerController.text =
        Provider.of<MainProvider>(context, listen: false).containerStorage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: myAppBar(context),
      body: ProgressHUD(
        child: Builder(
          builder: (BuildContext _context) => SingleChildScrollView(
            child: _body(_context),
          ),
        ),
      ),
    );
  }

  errorExtStor() {
    if (Provider.of<MainProvider>(context, listen: false)
        .errorSettingsStorage) {
      return Text(
        Languages.of(context).errorExtStor,
        style: TextStyle(color: Colors.red, fontSize: 30),
      );
    }
    return Container();
  }

  _body(BuildContext _context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(Settings().height(context) * 0.02),
        width: Settings().width(context) * 0.8,
        height: Settings().height(context) * 0.9,
        child: Column(
          children: [
            errorServer1c(),
            settingsField(
              Languages.of(context).adressServer1c,
              _controllerServer1C,
              () {
                context
                    .read<MainProvider>()
                    .changeAdressServer1C(_controllerServer1C.text);
                setServer1C(_controllerServer1C.text);
              },
            ),
            SizedBox(
              height: Settings().height(context) * 0.01,
            ),
            errorExtStor(),
            settingsField(
              Languages.of(context).adressExtStor,
              _storageController,
              () {
                context
                    .read<MainProvider>()
                    .changeAdressStorage(_storageController.text);
                setStorage(_storageController.text);
              },
            ),
            settingsField(
              Languages.of(context).loginExtStor,
              _loginController,
              () {
                context
                    .read<MainProvider>()
                    .changeLoginStorage(_loginController.text);
                setStorageLogin(_loginController.text);
              },
            ),
            settingsField(
              Languages.of(context).passExtStor,
              _passwordController,
              () {
                context
                    .read<MainProvider>()
                    .changePasswordStorage(_passwordController.text);
                setStoragePassword(_passwordController.text);
              },
              true,
            ),
            settingsField(
              Languages.of(context).containerExtStor,
              _containerController,
              () {
                context
                    .read<MainProvider>()
                    .changeContainerStorage(_containerController.text);
                setStorageContainer(_containerController.text);
              },
            ),
            RaisedButton(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              color: Theme.of(context).primaryColor,
              child: Text(
                Languages.of(context).authAndClose,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              onPressed: () {
                syncAndGo();
              },
            ),
            SizedBox(
              height: Settings().height(context) * 0.01,
            ),
            RaisedButton(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Обновить',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              onPressed: () {
                _checkUpdate(_context);
              },
            ),
          ],
        ),
      ),
    );
  }

  _checkUpdate(BuildContext _context) async {
    final progress = ProgressHUD.of(_context);
    progress.showWithText('Загрузка обновлений...');
    String result = await checkUpdate();
    progress.dismiss();
    if (result != '') {
      showDialog(
        context: _context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ошибка обновлений'),
            content: Text(result),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  syncAndGo() async {
    await syncData(context);
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  settingsField(String label, TextEditingController _ctr, Function _onSub,
      [bool passType = false]) {
    return Expanded(
      child: TextField(
        controller: _ctr,
        obscureText: passType,
        decoration: InputDecoration(
          labelStyle:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 25),
          labelText: label,
          contentPadding:
              EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
        ),
        textAlign: TextAlign.start,
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30),
        onSubmitted: (String text) {
          _onSub();
        },
      ),
    );
  }

  errorServer1c() {
    if (Provider.of<MainProvider>(context, listen: false).errorSettings) {
      return Text(
        Languages.of(context).errorServer1c,
        style: TextStyle(color: Colors.red, fontSize: 30),
      );
    }
    return Container();
  }

  scanButton(BuildContext context, FocusNode textFieldFocus) {
    return MaterialButton(
      onPressed: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageIcon(
            AssetImage('assets/icons/barcode.png'),
            size: 40,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
