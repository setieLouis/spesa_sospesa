import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spesa_sospesa/app_session.dart';
import 'package:spesa_sospesa/simple_helper_view.dart';

import 'Helper.dart';
import 'admin_helper_view.dart';
import 'http_caller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppSession(),
      child: MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: InitPage()),
      ),
    ),
  );
}

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}

// ignore: must_be_immutable
class Login extends StatelessWidget {
  String _inputValue;
  Helper _helper;
  final formakey = GlobalKey<FormState>();
  HttpCaller _httpCaller = HttpCaller();
  SharedPreferences preference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(30),
                // height: (size.height / 3) * 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400].withOpacity(0.3),
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey[100]),
                            ),
                          ),
                          child: Form(
                              key: formakey,
                              child: TextFormField(
                                onChanged: (value) {
                                  print(value);
                                  _inputValue = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty || _helper == null) {
                                    return "this $value is wrong";
                                  }
                                  return null;
                                },
                                onSaved: (value) => print(value),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Code",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                              ))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 60,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blueGrey[400].withOpacity(1),
                      ),
                      child: FlatButton(
                        onPressed: () async {
                          await checkUser();

                          if (formakey.currentState.validate()) {
                            redirect(context);
                          }
                        },
                        child: Center(
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
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
  }

  Future<bool> checkInstance() async {
    preference = await SharedPreferences.getInstance();
    return await preference.containsKey(_inputValue);
  }

  Future<bool> getHelper() async {
    return await preference.get(_inputValue);
  }


  Future<void> checkUser() async {
    if (_inputValue == null || _inputValue.isEmpty) {
      return;
    }
    if (!await checkInstance()) {
      _helper = await _httpCaller.helperById(_inputValue);

      if (_helper != null) {
        save(_inputValue, _helper.role);
      }
    } else {
      _helper = Helper();
    }
  }

  void redirect(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return (preference.get(_inputValue) == "Admin")
              ? AdminHelperView(_inputValue)
              : SimpleHelperView(_inputValue, false);
        }));
  }

  void save(String userId, String role) {
    preference.setString("userId", userId);
    preference.setString(userId, role);
  }
}



