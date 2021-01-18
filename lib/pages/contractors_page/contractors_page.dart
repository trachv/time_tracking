import 'package:flutter/material.dart';
import 'package:time_tracking/localization/language/languages.dart';
import 'package:time_tracking/providers/main_provider.dart';
import 'package:time_tracking/servises/settings.dart';
import 'package:time_tracking/widgets/app_bar.dart';
import 'package:time_tracking/servises/sync_data.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking/widgets/numpad.dart';
import 'dart:async';

class ContractorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: BodyContractor(),
    );
  }
}

class BodyContractor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Settings().height(context) * 0.02),
      child: Row(
        children: [
          LeftColumn(),
          SizedBox(
            width: Settings().width(context) * 0.01,
          ),
          RightColumn(),
        ],
      ),
    );
  }
}

class LeftColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Theme.of(context).primaryColor,
      width: Settings().width(context) * 0.6,
      child: Container(
        width: double.infinity,
        child: ColumnLeftColumn(),
      ),
    );
  }
}

Widget _getIcon(
    int index, BuildContext context, List<dynamic> _contractorsList) {
  if (context.watch<MainProvider>().currentContractor ==
      _contractorsList[index]['guid']) {
    return Icon(
      Icons.radio_button_checked,
      size: 40,
    );
  } else {
    return Icon(
      Icons.radio_button_unchecked,
      size: 40,
    );
  }
}

class ColumnLeftColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<dynamic> _contractorsList =
        context.watch<MainProvider>().contractorsList;
    return Column(
      children: [
        Center(
          child: Text(
            Languages.of(context).conpanyListTitle,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: _contractorsList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<MainProvider>().changecurrentContractor(
                            _contractorsList[index]['guid']);
                        context
                            .read<MainProvider>()
                            .changecurrentContractorName(
                                _contractorsList[index]['name']);
                      },
                      child: Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading:
                                  _getIcon(index, context, _contractorsList),
                              title: Text(
                                _contractorsList[index]['name'],
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class RightColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Settings().width(context) * 0.36,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmploeeCoutn(),
          SizedBox(
            height: Settings().height(context) * 0.01,
          ),
          NumPad(
            del: () => context.read<MainProvider>().changeWorkerCountDelete(),
            add: (int index) =>
                context.read<MainProvider>().changeWorkerCountAdd(index),
            goto: (BuildContext _context) {
              processContractor(_context);
            },
          ),
          SizedBox(
            height: Settings().height(context) * 0.01,
          ),
          CompliteButton(),
        ],
      ),
    );
  }
}

class CompliteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          processContractor(context);
        },
        child: Container(
          padding: EdgeInsets.only(top: 7, bottom: 7),
          child: Text(
            Languages.of(context).buttonCompliteTitle,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}

processContractor(BuildContext _context) async {
//send data to 1c
  String _errorContractorData = await sendContractorData(_context);
  showContractorInfo(
      _context, (_errorContractorData == null) ? '' : _errorContractorData);
}

showContractorInfo(BuildContext _context, String errMsg) {
  String _hour = DateTime.now().hour.toString().padLeft(2, '0');
  String _minute = DateTime.now().minute.toString().padLeft(2, '0');
  showDialog(
    context: _context,
    builder: (BuildContext context) {
      Timer(Duration(seconds: 5), () {
        _context.read<MainProvider>().changecurrentContractor('');
        _context.read<MainProvider>().changeWorkerCountClear();
        _context.read<MainProvider>().changeWorkerCode('');
        print('go to home from contractors page');
        Navigator.pushNamedAndRemoveUntil(
            context, '/homePage', (Route<dynamic> route) => false);
      });
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: Settings().height(context) * 0.25,
                child: Image(
                  image: AssetImage('assets/images/person_card.png'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child:
                    Text(context.watch<MainProvider>().currentContractorName),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(context.watch<MainProvider>().workerCount +
                    ' ' +
                    Languages.of(context).worker),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(errMsg),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  _hour + ':' + _minute,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class EmploeeCoutn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    _controller.text = context.watch<MainProvider>().workerCount;
    return TextField(
      decoration: InputDecoration(
        hintText: Languages.of(context).workerCountHint,
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
