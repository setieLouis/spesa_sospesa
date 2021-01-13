import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spesa_sospesa/http_caller.dart';
import 'package:spesa_sospesa/package_view.dart';
import 'package:spesa_sospesa/product.dart';

import 'custom_btn.dart';
import 'family.dart';

// ignore: must_be_immutable
class ExcelResultView extends StatelessWidget {

  final List<Spesa> spese;
  HttpCaller httpCaller = HttpCaller();

  ExcelResultView(this.spese);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        margin: EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomBtn(
                      icon: FontAwesomeIcons.check,
                      radius: 3,
                      height: 50,
                      width: 100,
                      borderColor: Colors.white,
                      background: Colors.green[400],
                      iconColor: Colors.white,
                      onPress: () async{
                        for(Spesa s in spese){
                          await save(s);
                        }
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10,),
                    CustomBtn(
                      icon: FontAwesomeIcons.times,
                      radius: 3,
                      height: 50,
                      width: 100,
                      borderColor: Colors.white,
                      background: Colors.red[400],
                      iconColor: Colors.white,
                      onPress: () => Navigator.pop(context),
                    )
                  ],

                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: spese.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckView(spese[index]);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }


  save(Spesa spesa) async{
    //httpCaller.deleteBig("family");
    //httpCaller.deleteBig("family");
    Map<String,dynamic> map = new Map();
    String faId =  await  httpCaller.updateFamily( Family.toJson(spesa.family), null);
    map[faId] = spesa.spesa;
    await httpCaller.saveBucket(map);
  }
}

class CheckView extends StatelessWidget {
  final Spesa spesa;

  CheckView(this.spesa);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400].withOpacity(0.5),
            blurRadius: 2.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: familyCount(spesa.family)),
        subtitle: Text(
          "Addresss",
          style: TextStyle(
              fontSize: 18,
              fontFamily: "montserrat",
              fontWeight: FontWeight.w400,
              color: Colors.blueGrey[600]),
        ),
        children: <Widget>[
          Text(
            spesa.family.helpers[0],
            style: TextStyle(
                fontSize: 20,
                fontFamily: "montserrat",
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey[400]),
          ),
          Text(
            spesa.family.helpers[1],
            style: TextStyle(
                fontSize: 20,
                fontFamily: "montserrat",
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey[400]),
          ),
          PackageView(Product.createListByString(spesa.spesa), null),
        ],
      ),
    );
  }

  List<Widget> familyCount(Family family) {
    List<Widget> childreen = [
      Text(
        "${family.name}",
        style: TextStyle(
            fontSize: 18,
            fontFamily: "montserrat",
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey[600]),
      ),
    ];

    for (int i = 0; i < family.adults; i++) {
      childreen.add(SizedBox(width: 10));
      childreen.add(
          FaIcon(FontAwesomeIcons.male, size: 25, color: Colors.blueGrey[300]));
    }

    for (int i = 0; i < family.boys; i++) {
      childreen.add(SizedBox(width: 10));
      childreen.add(
          FaIcon(FontAwesomeIcons.male, size: 20, color: Colors.blueGrey[300]));
    }

    for (int i = 0; i < family.baby; i++) {
      childreen.add(SizedBox(width: 10));
      childreen.add(
          FaIcon(FontAwesomeIcons.baby, size: 15, color: Colors.blueGrey[300]));
    }
    return childreen;
  }
}


class Spesa {
  Family family;
  List<String> spesa;

  Spesa() {
    spesa = [];
  }

  addOne(String one) {
    spesa.add(one);
  }
}
