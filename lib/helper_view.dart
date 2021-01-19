import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spesa_sospesa/AddFamilyView.dart';
import 'package:spesa_sospesa/http_caller.dart';

import 'Helper.dart';
import 'custom_btn.dart';

class FamilyView extends StatefulWidget {
  @override
  _FamilyViewState createState() => _FamilyViewState();
}

class _FamilyViewState extends State<FamilyView> {
  HttpCaller _httpCaller = HttpCaller();
  List<HelperMap> all;
  List<HelperMap> families;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveFamilies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addNew,
        child: FaIcon(FontAwesomeIcons.plus, size: 25, color: Colors.white),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(1),
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(0, 0),
              ),
            ]),
            child: SafeArea(
              child: Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: FaIcon(Icons.clear,
                          size: 30, color: Colors.blueGrey[300])),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SizedBox(
                    height: 50,
                    child: Container(
                      child: TextFormField(
                        onChanged: (value) {
                          onSearch(value);
                        },
                        cursorColor: Colors.blueGrey[200],
                        style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20, right: 20, bottom: 5),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Search",
                          fillColor: Colors.blueGrey[200],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueGrey[200],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[200],
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[200],
                              )),
                        ),
                        // validator: (value) => validator(value),
                        //onSaved: (value) => onSave(value),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(children: getFamiles() //getItem(),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void retrieveFamilies() async {
    List<HelperMap> tmp = await _httpCaller.allHelper();
    setState(() {
      all = tmp;
      families = tmp;
    });
  }

  List<Widget> getFamiles() {
    if (families == null) {
      return [];
    }
    List<Widget> container = [];
    for (HelperMap f in families) {
      container.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: CustomBtn(
            text: f.helper.name,
            radius: 10,
            width: 350,
            height: 60,
            shadow: false,
            borderColor: Colors.white,
            background: Colors.blueGrey[400],
            iconColor: Colors.white,

            /// TODO CONVERT THIS METHOD TO HELPER
            onPress: () => update(f),
          ),
        ),
      );
    }
    return container;
  }

  void update(HelperMap h) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddFamilyView(
                  helperMap: h,
                  title: '${h.helper.name}',
                  afterSave: () {
                    retrieveFamilies();
                    Navigator.pop(context);
                  },
                )));
  }

  void addNew() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFamilyView(
          title: 'New family',
          afterSave: () {
            retrieveFamilies();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void onSearch(String input) {
    List<HelperMap> local = [];
    input = input.toLowerCase();

    if (input != null && input
        .trim()
        .isNotEmpty) {
      for (HelperMap f in all) {
        if (f.helper.name.toLowerCase().contains(input)) {
          local.add(f);
        }
      }
    } else {
      local = all;
    }

    setState(() {
      families = local;
    });
  }
}
