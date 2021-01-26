import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
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
        child: MaterialApp(home: Login()),
      ),
    ),
  );
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _inputValue;
  Helper _helper;
  final formakey = GlobalKey<FormState>();
  HttpCaller _httpCaller = HttpCaller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                // width: size.width,
                // color: Colors.redAccent[400],
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    /**  SvgPicture.asset('assets/images/form.svg',
                        height: 200, width: 200),
                        Text(
                        "Dool",
                        style: TextStyle(
                        fontFamily: "Kanit",
                        fontSize: 35,
                        //#34495E
                        color: Colors.redAccent[400]
                        //color: Color(0xFF34495E)
                        ),
                        )**/
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(30),
                // height: (size.height / 3) * 2,
                child: Column(
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
                                  setState(() {
                                    _inputValue = value;
                                  });
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
                            redirect();
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

  Future<void> checkUser() async {
    if (_inputValue == null || _inputValue.isEmpty) {
      return;
    }
    _helper = await _httpCaller.helperById(_inputValue);
  }

  void redirect() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return (_helper.role == "Admin")
              ? AdminHelperView(_inputValue)
              : SimpleHelperView(_inputValue, false);
        }));
  }
}


