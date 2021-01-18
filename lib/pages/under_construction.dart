import 'dart:ui';

import 'package:flutter/material.dart';

class UnderConstraction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        //shadowColor: Colors.white,

        title: Text(
          'SAT: Учет рабочего времени',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 40,
            color: Theme.of(context).accentColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Страница в разработке',
              style: TextStyle(fontSize: 25),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Image(
                    image: AssetImage('assets/images/home-slider.gif'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
