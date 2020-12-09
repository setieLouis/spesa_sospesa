import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:spesa_sospesa/app_session.dart';
import 'package:spesa_sospesa/package_view.dart';
import 'package:spesa_sospesa/product.dart';
import 'package:spesa_sospesa/shoping_bucket.dart';
import 'package:url_launcher/url_launcher.dart';

import 'family.dart';

class DeliverView extends StatefulWidget {
  final FamilyMap family;

  const DeliverView({Key key, this.family}) : super(key: key);


  @override
  _DeliverViewState createState() => _DeliverViewState();
}



class _DeliverViewState extends State<DeliverView> {

  ShoppingBucket bucket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setBucket();
  }


  setBucket() async{

     ShoppingBucket tmp = await context.read<AppSession>().familyBucket(widget.family.familyId);
      setState(() {
        bucket = tmp;
      });
  }

  final TextStyle itemStyle =
  TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

  final Container customSep = Container(
    height: 5,
    margin: EdgeInsets.symmetric(vertical: 2),
    color: Colors.grey.withOpacity(0.1),
    //color: Colors.white,
  );




  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: SafeArea(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: familyCount()
                )),
          ),
          Flexible(flex: 7, child: getBody())
        ],
      ),
    );
  }


  List<Widget>  familyCount(){

    List<Widget> childreen = [

      IconButton(
        padding: EdgeInsets.all(0),
          onPressed: () {
           widget.family.family.state = bucket.state;
           context.read<AppSession>().notify();
            Navigator.pop(context);
          },
          icon : FaIcon(FontAwesomeIcons.arrowLeft, size: 18, color: Colors.blueGrey[300])
      ),

      Text(
        "${widget.family.family.name}",
        style: TextStyle(
            fontSize: 20,
            fontFamily: "montserrat",
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey[600]),
      ),
    ];

    for(int i = 0; i  < widget.family.family.adults; i++){
      childreen.add( SizedBox(width: 10));
      childreen.add(FaIcon(FontAwesomeIcons.male, size: 25, color: Colors.blueGrey[300]));
    }

    for(int i = 0; i  < widget.family.family.boys; i++){
      childreen.add( SizedBox(width: 10));
      childreen.add(FaIcon(FontAwesomeIcons.male, size: 20, color: Colors.blueGrey[300]));
    }

    for(int i = 0; i  < widget.family.family.baby; i++){
      childreen.add( SizedBox(width: 10));
      childreen.add(FaIcon(FontAwesomeIcons.baby, size: 15, color: Colors.blueGrey[300]));
    }
    return childreen;
  }
  getBody() {

    if(bucket == null)
      return Container();

    if (bucket.state == DELIVERING || bucket.state == DELIVERED ) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          InfoRow(widget.family.family.address, FontAwesomeIcons.mapMarkerAlt,
              onPress: () {
                MapsLauncher.launchQuery(
                    '${widget.family.family.address}, ${widget.family.family.city}');
              }),
          InfoRow(widget.family.family.intercom, FontAwesomeIcons.intercom),
          InfoRow(
            widget.family.family.phone,
            FontAwesomeIcons.phone,
            onPress: () {
              launch('tel:// ${widget.family.family.phone}');
            },
          ),
          Expanded(child: getDeliverBtn())
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: InfoRow(
            widget.family.family.phone,
            FontAwesomeIcons.phone,
            onPress: () {
              launch('tel:// ${widget.family.family.phone}');
            },
          ),
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: PackageView(bucket.bucket, (int index) {
              setState(() {
                bucket.bucket[index].toggle();
                if(checkAllDone()){
                  bucket.nextState();
                }else{
                  bucket.previousState();
                }
              });
            }),
          ),
        ),
        Expanded(flex: 2, child: getPackageBtn())
      ],
    );
  }

  bool checkAllDone() {
    bool allAdded = true;
    for (Product pro in bucket.bucket) {
      if (!pro.added) {
        allAdded = false;
        break;
      }
    }
    return allAdded;
  }

  DoneBtn getDeliverBtn() {
    return bucket.state == DELIVERED
        ? DoneBtn(FontAwesomeIcons.check,
        borderColor: Colors.white,
        background: Colors.white,
        iconColor: Colors.green)
        : DoneBtn(FontAwesomeIcons.peopleCarry,
        onPress: () => setState(() => bucket.nextState()));
  }

  DoneBtn getPackageBtn() {
    return bucket.state == PACKAGED
        ? DoneBtn(FontAwesomeIcons.box,
        circleSize: 80,
        borderColor: Colors.white,
        iconColor: Colors.green,
        onPress: () => setState(() => bucket.nextState()))
        : DoneBtn(FontAwesomeIcons.boxOpen,
        circleSize: 80);
  }
}




class InfoRow extends StatelessWidget {
  final String value;
  final IconData icon;
  void Function() onPress;

  InfoRow(this.value, this.icon, {this.onPress}) {
    if (onPress == null) {
      onPress = () {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => onPress(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              FaIcon(this.icon, size: 20, color: Colors.blueGrey[600]),
              SizedBox(
                width: 10,
              ),
              Text(
                this.value,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "montserrat",
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey[400]),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DoneBtn extends StatelessWidget {
  double circleSize;
  double internalCircleSize;

  void Function() onPress;
  final IconData icon;
  Color borderColor;
  Color background;
  Color iconColor;
//
  DoneBtn(this.icon,
      {this.borderColor,
        this.background,
        this.iconColor,
        this.onPress,
        this.circleSize = 160.0}) {
    if (this.onPress == null) {
      onPress = () {};
    }

    if (borderColor == null) {
      borderColor = Colors.blueGrey[100];
    }

    if (background == null) {
      background = Colors.white;
    }

    if (iconColor == null) {
      iconColor = Colors.blueGrey[200];
    }

    internalCircleSize = getInterneCircle();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: circleSize,
        width: circleSize,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(circleSize / 2),
            border: Border.all(width: 5, color: borderColor)),
        child: Center(
          child: Container(
            height: internalCircleSize,
            width: internalCircleSize,
            decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(internalCircleSize / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400].withOpacity(0.3),
                    blurRadius: 5.0,
                    spreadRadius: 3,
                    offset: Offset(0, 0),
                  ),
                ]),
            child: FlatButton(
              shape: CircleBorder(),
              onPressed: () => onPress(),
              child: Center(
                child: FaIcon(icon, size: getInconSize(), color: iconColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double getInterneCircle() {
    double interne = ((85 * circleSize) / 100);
    return interne;
  }

  double getInconSize() {
    double size = ((30 * circleSize) / 100);
    return size;
  }
}