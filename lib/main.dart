import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking/pages/comin_page/comin_page.dart';
import 'package:time_tracking/pages/contractors_page/contractors_page.dart';

import 'package:time_tracking/pages/home_page/home_page.dart';
import 'package:time_tracking/pages/infoworker_page/infoworker_page.dart';
import 'package:time_tracking/pages/inout_page/inout_page.dart';
import 'package:time_tracking/pages/settings_page/settings_page.dart';
import 'package:time_tracking/pages/under_construction.dart';
import 'package:time_tracking/providers/main_provider.dart';
import 'package:time_tracking/localization/locate_constant.dart';
import 'package:time_tracking/localization/localizations_delegate.dart';
import 'package:time_tracking/servises/sync_data.dart';
import 'package:time_tracking/models/language_data.dart';
import 'dart:async';
import 'package:time_tracking/servises/settings.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => MainProvider(),
      )
    ],
    child: TimeTrackingApp(),
  ));
}

class TimeTrackingApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_TimeTrackingApp>();
    state.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _TimeTrackingApp();
}

class _TimeTrackingApp extends State<TimeTrackingApp> {
  Locale _locale;

  final _navigatorKey = GlobalKey<NavigatorState>();
  Timer _timer;
  bool _authOk = false;
  String _currentRoute = '';

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeTimer();
    initializePref(context);

    _syncDataloc();
  }

  void _syncDataloc() async {
    bool _authOk = await syncData(context);
    Timer(const Duration(seconds: 30), () => _syncDataloc());

    Navigator.popUntil(_navigatorKey.currentContext, (route) {
      _currentRoute = route.settings.name;
      print(route.settings.name);
      return true;
    });

    if (!_authOk && _currentRoute != '/settingsPage') {
      _navigatorKey.currentState.pushNamed('/settingsPage');
    }
  }

  void _initializeTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(seconds: 30), _inactiveAction);
  }

  void _inactiveAction() {
    if (_currentRoute != '/settingsPage') {
      _timer?.cancel();
      _timer = null;
      Provider.of<MainProvider>(context, listen: false).cleanGoHome();
      _navigatorKey.currentState.popUntil((r) => r.isFirst);
      _navigatorKey.currentState.pushNamedAndRemoveUntil('/', (_) => false);
    }
  }

  void _handleUserInteraction([_]) {
    _initializeTimer();
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
        context
            .read<MainProvider>()
            .changeLocale(LanguageData.languageData(locale.languageCode));
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('main is rebuild');
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _handleUserInteraction,
      onPanDown: _handleUserInteraction,
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        home: HomePage(),
        theme: themeData(),
        routes: {
          '/homePage': (context) => HomePage(),
          '/cominPage': (context) => CominPage(),
          '/infoworkerPage': (context) => InfoworkerPage(),
          '/contractorsPage': (context) => ContractorsPage(),
          '/underConstraction': (content) => UnderConstraction(),
          '/inoutPage': (content) => InoutPage(),
          '/settingsPage': (content) => SettingsPage(),
        },
        debugShowCheckedModeBanner: false,
        locale: _locale,
        supportedLocales: [Locale('uk', ''), Locale('ru', '')],
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale?.languageCode == locale?.languageCode &&
                supportedLocale?.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales?.first;
        },
      ),
    );
  }
}

ThemeData themeData() {
  return ThemeData(
    primaryColor: Color(0xFF154398),
    accentColor: Color(0xFFedab00),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Color(0xFFedab00),
        fontFamily: 'Roboto',
        fontSize: 50,
      ),
      bodyText2: TextStyle(
        color: Color(0xFFedab00),
        fontFamily: 'Roboto',
        fontSize: 40,
      ),
      headline1: TextStyle(
        color: Color(0xFFedab00),
        fontFamily: 'Roboto',
        fontSize: 100,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontSize: 50,
      ),
    ),
  );
}
