import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spesa_sospesa/app_session.dart';
import 'package:spesa_sospesa/deliver_view.dart';
import 'package:spesa_sospesa/simple_helper_view.dart';

import 'AddFamilyView.dart';
import 'FamilyView.dart';
import 'custom_btn.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppSession(),
      child: MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: AdminHelperView(),
        ),
      ),
    ),
  );
}

class AdminHelperView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: <Widget>[
              Container(
                  width: 300,
                  child: CustomBtn(
                    icon: FontAwesomeIcons.handHoldingHeart,
                    text: "Helpe",
                    radius: 10,
                    height: 140,
                    width: 330,
                    borderColor: Colors.white,
                    background: Colors.blueGrey[400],
                    iconColor: Colors.white,
                  )),
              Container(
                  width: 150,
                  child: CustomBtn(
                    icon:FontAwesomeIcons.home,
                    text: "Family",
                    radius: 10,
                    height: 150,
                    borderColor: Colors.white,
                    background: Colors.blueGrey[400],
                    iconColor: Colors.white,
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FamilyView()));
                    },
                  )),
              Container(
                  width: 150,
                  child: CustomBtn(
                    icon: FontAwesomeIcons.users,
                    text: "Add helper",
                    radius: 10,
                    height: 150,
                    borderColor: Colors.white,
                    background: Colors.blueGrey[400],
                    iconColor: Colors.white,
                  )),
              Container(
                  width: 150,
                  child: CustomBtn(
                    icon: FontAwesomeIcons.cogs,
                    text: "Setting",
                    radius: 10,
                    height: 150,
                    borderColor: Colors.white,
                    background: Colors.blueGrey[400],
                    iconColor: Colors.white,
                  )),
              Container(
                  width: 150,
                  child: CustomBtn(
                    icon: FontAwesomeIcons.calculator,
                    text: "Bucket",
                    radius: 10,
                    height: 150,
                    borderColor: Colors.white,
                    background: Colors.blueGrey[400],
                    iconColor: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
