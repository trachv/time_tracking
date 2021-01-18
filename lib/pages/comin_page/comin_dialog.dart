import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:time_tracking/providers/main_provider.dart';
import 'package:time_tracking/servises/settings.dart';
import 'package:time_tracking/localization/language/languages.dart';
import 'package:time_tracking/pages/comin_page/comin_servises.dart';

showScanDialog(BuildContext _context) {
  final _controller = TextEditingController();
  return showDialog(
    context: _context,
    builder: (BuildContext context) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      return Dialog(
        child: Container(
          width: Settings().width(context) * 0.4,
          height: Settings().height(context) * 0.4,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Text(Languages.of(context).codeTitle),
              ),
              TextField(
                autofocus: true,
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (String text) {},
                onSubmitted: (String text) {
                  context.read<MainProvider>().changeWorkerCode(text);
                  processBarcode(context,true);
                },
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text(
                  Languages.of(context).inputHandle,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

showErrorPopup(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: Settings().width(context) * 0.6,
          padding: EdgeInsets.all(20),
          child: Column(
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
                  child: Text(Languages.of(context).scanError),
                ),
              ),
              Container(
                height: Settings().height(context) * 0.15,
                child: Image(
                  image: AssetImage('assets/images/person_card.png'),
                ),
              ),
              SizedBox(
                height: Settings().height(context) * 0.03,
              ),
              Container(
                width: Settings().width(context) * 0.4,
                child: MaterialButton(
                  onPressed: () {
                    context.read<MainProvider>().changeWorkerCode('');
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, '/cominPage', (Route<dynamic> route) => false);
                    Navigator.of(context).pop();
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
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      ImageIcon(
                        AssetImage('assets/icons/barcode.png'),
                        size: 40,
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Settings().height(context) * 0.01,
              ),
              Container(
                width: Settings().width(context) * 0.4,
                child: MaterialButton(
                  onPressed: () {
                    context.read<MainProvider>().changeWorkerCode('');
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, '/cominPage', (Route<dynamic> route) => false);
                    Navigator.of(context).pop();
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
                          Languages.of(context).repeateEnterCode,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Settings().height(context) * 0.01,
              ),
              Container(
                width: Settings().width(context) * 0.4,
                child: MaterialButton(
                  onPressed: () {
                    context.read<MainProvider>().changeWorkerCode('');
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (Route<dynamic> route) => false);
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
                          Languages.of(context).goHome,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
