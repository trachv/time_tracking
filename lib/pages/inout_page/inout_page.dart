import 'package:flutter/material.dart';
import 'package:time_tracking/widgets/app_bar.dart';
import 'package:time_tracking/localization/language/languages.dart';
import 'package:time_tracking/pages/home_page/local_widgets/homemenu_element.dart';
import 'package:time_tracking/providers/main_provider.dart';
import 'package:time_tracking/servises/settings.dart';
import 'package:provider/provider.dart';

class InoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('InoutPage is rebuild' + DateTime.now().toIso8601String());
    return Scaffold(
      appBar: myAppBar(context),
      body: BodyComin(),
    );
  }
}

class BodyComin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Settings().height(context) * 0.02,
        right: Settings().height(context) * 0.02,
      ),
      child: Column(
        children: [
          SizedBox(
            height: Settings().height(context) * 0.015,
          ),
          HomeMenuElement(
            onTap: () {
                context.read<MainProvider>().changeTypeTime('1');
                //Navigator.pushNamed(context, '/contractorsPage');
                Navigator.pushNamedAndRemoveUntil(
            context, '/contractorsPage', (Route<dynamic> route) => false);
            },
            label: Languages.of(context).buttonTimeStart,
            icon: AssetImage('assets/icons/enter.png'),
          ),
          SizedBox(
            height: Settings().height(context) * 0.015,
          ),
          HomeMenuElement(
              onTap: () {
                  context.read<MainProvider>().changeTypeTime('2');
                  //Navigator.pushNamed(context, '/contractorsPage');
                   Navigator.pushNamedAndRemoveUntil(
            context, '/contractorsPage', (Route<dynamic> route) => false);
              },
              label: Languages.of(context).buttonTimeFinish,
              icon: AssetImage('assets/icons/logout.png')),
        ],
      ),
    );
  }
}
