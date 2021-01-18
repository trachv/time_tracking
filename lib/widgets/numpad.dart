import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:time_tracking/servises/settings.dart';

class NumPad extends StatelessWidget {
  final Function del;
  final Function add;
  final Function goto;

  NumPad({this.del, this.add, this.goto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 27, right: 27),
      height: Settings().height(context) * 0.655,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
               shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 12,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 17, right: 17),
                  child: MaterialButton(
                    shape: CircleBorder(),
                    child: _buttonTextIcon(index, context),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (index == 9) {
                        del();
                      } else if (index == 11) {
                        goto(context);
                      } else {
                        add(index);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _buttonTextIcon(int index, BuildContext context) {
    if (index == 9) {
      return ImageIcon(
        AssetImage('assets/icons/bs.png'),
        color: Theme.of(context).accentColor,
        size: 40,
      );
    } else if (index == 11) {
      return ImageIcon(
        AssetImage('assets/icons/ok.png'),
        color: Theme.of(context).accentColor,
        size: 40,
      );
    }
    return AutoSizeText(
      (index == 10) ? '0' : (index + 1).toString(),
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontFamily: 'Roboto',
        fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
      ),
    );
  }
}
