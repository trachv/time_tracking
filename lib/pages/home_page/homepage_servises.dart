import 'package:flutter/material.dart';
import 'package:time_tracking/servises/settings.dart';

showErrorPopup(BuildContext _context, String errorText) {
    return showDialog(
      context: _context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: Settings().width(context) * 0.4,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Settings().height(context) * 0.25,
                  child: ImageIcon(
                    AssetImage('assets/icons/error.png'),
                    color: Colors.red,
                    size: 200,
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text(errorText, textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }