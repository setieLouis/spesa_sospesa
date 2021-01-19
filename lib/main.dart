import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spesa_sospesa/app_session.dart';
import 'package:spesa_sospesa/family.dart';
import 'package:spesa_sospesa/simple_helper_view.dart';

import 'custom_btn.dart';
import 'exceL_result_View.dart';
import 'helper_view.dart';

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
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SimpleHelperView()));
                    },
                  )),
              Container(
                  width: 300,
                  child: CustomBtn(
                    icon: FontAwesomeIcons.users,
                    text: "Add helper",
                    radius: 10,
                    height: 140,
                    width: 330,
                    borderColor: Colors.white,
                    background: Colors.blueGrey[400],
                    iconColor: Colors.white,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FamilyView()));
                    },
                    //FamilyView
                  )),
              Container(
                  width: 300,
                  child: CustomBtn(
                    icon: FontAwesomeIcons.fileExcel,
                    text: "File excel",
                    radius: 10,
                    height: 140,
                    width: 330,
                    borderColor: Colors.white,
                    background: Colors.blueGrey[400],
                    iconColor: Colors.white,
                    onPress: () async {
                      FilePickerResult result =
                          await FilePicker.platform.pickFiles();
                      List<Spesa> spese;


                      if (result != null) {
                        List<int> file =
                        File(result.files.single.path).readAsBytesSync();

                        spese =  parseExcel( Excel.decodeBytes(file, update: true));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExcelResultView(spese)));
                      }

                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  List<String> getCols(String element) {

    if (element.trim() == "0") {
      return null;
    }

    return element.split("|");
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }


  List<Spesa> parseExcel(var excel){

    List<Spesa> spese = [];
    List<String> oldper = [];

    for (var table in excel.tables.keys) {
      print(table);
      print(excel.tables[table].maxRows);
      int maxRow = excel.tables[table].maxRows;

      print(excel.tables[table].rows[0]);
      var head = excel.tables[table].rows[0];

      for (int i = 1; i < maxRow; i++) {
        Family family = Family();
        var row = excel.tables[table].rows[i];




        List<String> h = getCols(row[0].toString());
        family.helpers =  h == null || h[0] == "null" ? oldper : h;
        family.phone = row[3].toString();
        family.address = row[4].toString();
        var member = getCols(row[5].toString());
        family.adults = int.parse(member[0]);
        family.boys =
        member.length > 1 ? int.parse(member[1]) : 0;
        family.baby =
        member.length > 2 ? int.parse(member[2]) : 0;
        //family.info =  member.length > 2 ? int.parse(member[2]): 0;
        family.name = row[2].toString();

        /// we use this variable when new row don't have field helpers
        oldper = family.helpers;


        Spesa spesa = Spesa();
        spesa.family = family;

        int maxCol = excel.tables[table].maxCols;
        for (int j = 4; j < maxCol; j++) {
          List<String> cols = getCols(row[j].toString());
          if (cols == null) {
            continue;
          }

          for (String el in cols) {
            spesa.addOne(isNumeric(el)
                ? " ${head[j]} $el"
                : "${el.trim()}");
          }
        }

        spese.add(spesa);
      }
    }
    return spese;
  }

}

