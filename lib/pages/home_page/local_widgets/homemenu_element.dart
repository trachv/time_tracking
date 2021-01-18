import 'package:flutter/material.dart';
import 'package:time_tracking/servises/settings.dart';

class HomeMenuElement extends StatelessWidget {
  final Function onTap;
  final String label;
  final AssetImage icon;

  HomeMenuElement({
    this.onTap,
    this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.green,
      onTap: onTap,
      child: SizedBox(
        height: Settings().height(context) * 0.28,
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  icon,
                  size: 100,
                  color: Theme.of(context).accentColor,
                ),
                Text(
                  label,
                  style: TextStyle(
                      fontSize: 40, color: Theme.of(context).accentColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
