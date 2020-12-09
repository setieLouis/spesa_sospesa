import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_sospesa/app_session.dart';
import 'package:spesa_sospesa/simple_helper_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>  AppSession(),
      child: MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: SimpleHelperView(),
        ),
      ),
    ),
  );
}


class AdminHelperView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
