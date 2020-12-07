import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spesa_sospesa/app_session.dart';
import 'package:spesa_sospesa/shoping_bucket.dart';

import 'deliver_view.dart';
import 'family.dart';
import 'family.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>  AppSession(),
      child: MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: FamilyView(),
        ),
      ),
    ),
  );
}


class FamilyView extends StatefulWidget {
  @override
  _FamilyViewState createState() => _FamilyViewState();
}

class _FamilyViewState extends State<FamilyView> {

  final List<Family> family  = [
    Family(
        name: "Bogoni Laura",
        adults: 1,
        boys: 0,
        baby: 0,
        phone: "3478955772",
        address: "Via Libertà,30",
        city: "Cesano Boscone"
    ),

    Family(
        name: "Maringelli Massimiliano",
        adults: 2,
        boys: 2,
        baby: 0,
        phone: "3911340962",
        address: "Via delle acacie,12",
        city: "Cesano Boscone"
    ),

    Family(
        name: "Vasta Maria",
        adults: 3,
        boys: 0,
        baby: 0,
        phone: "3478955772",
        address: "Via Cellini 26",
        city: "Cesano Boscone"
    ),

    Family(
        name: "Putignano Davide",
        adults: 2,
        boys: 0,
        baby: 2,
        phone: "3478955772",
        address: "Via Cellini 26",
        city: "Cesano Boscone"
    ),
  ];


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Center(
                      child: SvgPicture.asset('assets/images/hold_heart.svg',
                          height: 130, width: 130)
                  ),
                ),
              )
          ),

          Expanded(
            flex: 6,
            child: ListView.builder(
                itemCount: family.length,
                itemBuilder: (BuildContext context, int index){

                  Family current = family[index];
                  return Consumer<AppSession>(builder: (context, appSession, child){
                    return   Container(
                      margin: EdgeInsets.symmetric(vertical: 5 , horizontal: 10 ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400].withOpacity(0.5),
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: FlatButton(

                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return DeliverView(family: current);
                              }));
                        },
                        child: ListTile(
                          title: Text(current.name, style: TextStyle(
                              fontSize: 14,
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w300,
                              color: Colors.blueGrey[800]),
                        ),
                          trailing: getStateIcon(appSession.getStateByOwner(current.name)),
                        ),
                      ),
                    );;
                  });
                }
            ),
          )


        ],
      ),
    );
  }

  FaIcon getStateIcon( DeliverState state) {
    switch( state ){

      case DeliverState.packaged:
        return  FaIcon(FontAwesomeIcons.box , size: 25,color: Colors.yellow[800],);
      case DeliverState.delivering:
        return  FaIcon(FontAwesomeIcons.peopleCarry , size: 25,color: Colors.lightBlue,);
      case DeliverState.delivered:
        return FaIcon(FontAwesomeIcons.check , size: 25,color: Colors.green,);
      default :
        return  FaIcon(FontAwesomeIcons.boxOpen, size: 25,color: Colors.teal,);
    }
  }

}

//


/**



**/