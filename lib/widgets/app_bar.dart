import 'package:auto_size_text/auto_size_text.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:time_tracking/localization/language/languages.dart';
import 'package:time_tracking/localization/locate_constant.dart';
import 'package:time_tracking/models/language_data.dart';
import 'package:time_tracking/providers/main_provider.dart';
import 'package:time_tracking/servises/settings.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking/servises/sync_data.dart';

myAppBar(BuildContext context) {
  String _devRegister = '';
  if (Provider.of<MainProvider>(context).deviceRegister) {
    _devRegister = ' (Авторизован)';
  } else {
    _devRegister = ' (Демо)';
  }
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            syncData(context);
          },
          child: Container(
            padding: EdgeInsets.all(0),
            width: Settings().width(context) * 0.65,
            child: AutoSizeText(
              Languages.of(context).appName + _devRegister,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
        Row(
          children: [
            Drop(),
            IconButton(
              icon: Icon(Icons.settings, size: 35,),
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.pushNamed(
                            context, '/settingsPage');
              },
            ),
          ],
        ),
      ],
    ),
    centerTitle: true,
  );
}

class Drop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _languageList = LanguageData.languageList();
    LanguageData _findLanguageData() {
      var _locale = context.watch<MainProvider>().locale;
      String _lcode = 'uk';
      if (_locale != null) {
        _lcode = _locale.languageCode;
      }
      return _languageList.firstWhere((_elem) => _elem.languageCode == _lcode);
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<LanguageData>(
        dropdownColor: Colors.white,
        value: _findLanguageData(),
        onChanged: (LanguageData language) {
          changeLanguage(context, language.languageCode);
        },
        items: _languageList.map<DropdownMenuItem<LanguageData>>((_value) {
          return DropdownMenuItem<LanguageData>(
            value: _value,
            child: Row(
              children: <Widget>[
                Flag(
                  _value.flag,
                  width: Settings().width(context) * 0.03,
                  height: Settings().height(context) * 0.03,
                ),
                SizedBox(
                  width: Settings().width(context) * 0.015,
                ),
                AutoSizeText(
                  _value.name,
                  style: Theme.of(context).textTheme.bodyText2,
                  maxLines: 1,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
