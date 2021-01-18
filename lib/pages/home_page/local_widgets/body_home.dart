import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking/localization/language/languages.dart';
import 'package:time_tracking/pages/home_page/local_widgets/homemenu_element.dart';
import 'package:time_tracking/pages/home_page/homepage_servises.dart';
import 'package:time_tracking/providers/main_provider.dart';
import 'package:time_tracking/servises/settings.dart';

class BodyHome extends StatelessWidget {

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
              if (!Provider.of<MainProvider>(context, listen: false)
                  .deviceRegister) {
                showErrorPopup(
                    context,
                    Languages.of(context).errorNotRegister +
                        Provider.of<MainProvider>(context, listen: false)
                            .devId);
              } else {
                context.read<MainProvider>().changeTypeTime('1');
                Navigator.pushNamed(context, '/cominPage');
            //     Navigator.pushNamedAndRemoveUntil(
            // context, '/cominPage', (Route<dynamic> route) => false);
              }
            },
            label: Languages.of(context).buttonTimeStart,
            icon: AssetImage('assets/icons/enter.png'),
          ),
          SizedBox(
            height: Settings().height(context) * 0.015,
          ),
          HomeMenuElement(
              onTap: () {
                if (!Provider.of<MainProvider>(context, listen: false)
                    .deviceRegister) {
                  showErrorPopup(
                      context,
                      Languages.of(context).errorNotRegister +
                          Provider.of<MainProvider>(context, listen: false)
                              .devId);
                } else {
                  context.read<MainProvider>().changeTypeTime('2');
                  Navigator.pushNamed(context, '/cominPage');
            //       Navigator.pushNamedAndRemoveUntil(
            // context, '/cominPage', (Route<dynamic> route) => false);
                }
              },
              label: Languages.of(context).buttonTimeFinish,
              icon: AssetImage('assets/icons/logout.png')),
          SizedBox(
            height: Settings().height(context) * 0.015,
          ),
          HomeMenuElement(
              onTap: () {
                if (!Provider.of<MainProvider>(context, listen: false)
                    .deviceRegister)  {
                  showErrorPopup(
                      context,
                      Languages.of(context).errorNotRegister +
                          Provider.of<MainProvider>(context, listen: false)
                              .devId);
                } else {
                   context.read<MainProvider>().changeTypeTime('3');
                  Navigator.pushNamed(context, '/cominPage');
            //        Navigator.pushNamedAndRemoveUntil(
            // context, '/cominPage', (Route<dynamic> route) => false);
                }
              },
              label: Languages.of(context).buttonContractors,
              icon: AssetImage('assets/icons/group.png')),
        ],
      ),
    );
  }
}
