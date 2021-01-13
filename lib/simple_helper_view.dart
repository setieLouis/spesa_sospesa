
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'app_session.dart';
import 'deliver_view.dart';
import 'family.dart';


const  HOLD_HEART = 'assets/images/hold_heart.svg';
class SimpleHelperView extends StatefulWidget {

  @override
  _SimpleHelperViewState createState() => _SimpleHelperViewState();
}

class _SimpleHelperViewState extends State<SimpleHelperView> {

  @override
  void initState() {

    super.initState();
    context.read<AppSession>()..allFamily();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSession>(builder: (context, appSession, child){

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
                        child: SvgPicture.asset(HOLD_HEART,
                            height: 130, width: 130)
                    ),
                  ),
                )
            ),

            Expanded(
              flex: 6,
              child: ListView.builder(
                  itemCount: appSession.families.length,
                  itemBuilder: (BuildContext context, int index){
                    FamilyMap current = appSession.families[index];
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

                          /// move deliver view
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return DeliverView(family: current);
                              }));
                        },
                        child: ListTile(
                          title: Text(current.family.name, style: TextStyle(
                              fontSize: 14,
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w300,
                              color: Colors.blueGrey[800]),
                          ),
                          trailing: getStateIcon( current.family.state),
                        ),
                      ),
                    );
                  }
              ),
            )

          ],
        ),
      );
    });


  }

  FaIcon getStateIcon( String  state) {
    switch( state ){

      case  "packaged":
        return  FaIcon(FontAwesomeIcons.box , size: 25,color: Colors.yellow[800],);
      case  "delivering":
        return  FaIcon(FontAwesomeIcons.peopleCarry , size: 25,color: Colors.lightBlue,);
      case  "delivered":
        return FaIcon(FontAwesomeIcons.check , size: 25,color: Colors.green,);
      default :
        return  FaIcon(FontAwesomeIcons.boxOpen, size: 25,color: Colors.teal,);
    }
  }

}