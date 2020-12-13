
// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class CustomBtn extends StatelessWidget {

  double height;
  double width;
  double internalHeight;
  double internalWidth;
  double radius;

  void Function() onPress;
  IconData icon;
  Color borderColor;
  Color background;
  Color iconColor;
  String text;
  bool shadow;

  CustomBtn(
      {
        this.icon,
        Color borderColor,
        Color background,
        Color iconColor,
        double radius,
        Function()  onPress,
        double height = 160.0,
        double width,
        this.text,
        this.shadow = true
      }) {

    this.height = height;
    this.width = width == null ? height: width;
    this.onPress = onPress == null ?  () {}: onPress;
    this.radius = radius == null ?  this.height / 2 : radius;
    this.borderColor = borderColor == null ? Colors.blueGrey[100]  : borderColor;
    this.background = background == null ?  Colors.white : background;
    this.iconColor = iconColor == null ? Colors.blueGrey[200] : iconColor;
    this.internalHeight = calculePercent(this.height, 85);
    this.internalWidth = calculePercent(this.width, 85);
  }
  @override
  Widget build(BuildContext context) {

    double externalRadius = (radius != height/2) ? radius : internalHeight / 2;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(width: 5, color: borderColor)),
      child: Center(
        child: Container(
          height: internalHeight,
          width: internalWidth,
          decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(externalRadius),
              boxShadow: getShadow(),),
          child: FlatButton(
            shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            onPressed: () => onPress(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 getIcon(),
                  getText()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double calculePercent(double lon, double percent) {
    double interne = ((percent * lon) / 100);
    return interne;
  }

  double getInconSize() {
    double size = ((30 * height) / 100);
    return size;
  }

  Widget getText() {

    if(text != null){
      return Padding(
        padding: EdgeInsets.only(top: 5),
        child: Text(text, style: TextStyle(
            color: iconColor,
            fontSize: 16,
            fontWeight: FontWeight.w600
        ), ),
      );
    }
    return Container();
  }

  Widget getIcon() {

    if(icon != null){
      return FaIcon(icon, size: getInconSize(), color: iconColor);
    }

    return Container();
  }

  List<BoxShadow> getShadow(){
    List<BoxShadow> shadows = [];
    if(shadow){
       shadows.add(
        BoxShadow(
          color: Colors.grey[400].withOpacity(0.3),
          blurRadius: 5.0,
          spreadRadius: 3,
          offset: Offset(0, 0),
        ),
      );
    }

    return shadows;
  }
}