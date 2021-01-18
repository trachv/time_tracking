import 'package:flutter/material.dart';
import 'package:time_tracking/localization/language/languages.dart';
import 'package:time_tracking/servises/settings.dart';
import 'package:time_tracking/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking/providers/main_provider.dart';
import 'package:time_tracking/widgets/numpad.dart';
import 'package:time_tracking/pages/comin_page/comin_servises.dart';
import 'package:time_tracking/pages/comin_page/comin_dialog.dart';

class CominPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CominPage();
}

class _CominPage extends State<CominPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showScanDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('CominPage is rebuild');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: myAppBar(context),
      body: BodyComin(),
    );
  }
}

class BodyComin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(Settings().height(context) * 0.02),
        width: Settings().width(context) * 0.37,
        child: Column(
          children: [
            Code(),
            SizedBox(
              height: Settings().height(context) * 0.01,
            ),
            NumPad(
              del: () => context.read<MainProvider>().changeWorkerCodeDelete(),
              add: (int index) =>
                  context.read<MainProvider>().changeWorkerCodeAdd(index),
              goto: (BuildContext _context) {
                processBarcode(_context, false);
              },
            ),
            SizedBox(
              height: Settings().height(context) * 0.01,
            ),
            ScanButton(),
          ],
        ),
      ),
    );
  }
}

class Code extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    _controller.text = context.watch<MainProvider>().workerCode;
    return TextField(
      decoration: InputDecoration(
        hintText: Languages.of(context).codeHint,
        border: new OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).primaryColor,
        contentPadding: EdgeInsets.only(bottom: 15, left: 10),
      ),
      readOnly: true,
      style: Theme.of(context).textTheme.bodyText1,
      controller: _controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onChanged: (String text) {
        context.read<MainProvider>().changeWorkerCode(text);
      },
    );
  }
}

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        showScanDialog(context);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: Text(
              Languages.of(context).buttonScan,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
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
