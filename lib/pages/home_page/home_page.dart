import 'package:flutter/material.dart';
import 'package:time_tracking/widgets/app_bar.dart';
import 'local_widgets/body_home.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: myAppBar(context),
      body: BodyHome(),
    );
  }
}


