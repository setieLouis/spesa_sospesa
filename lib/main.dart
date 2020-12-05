import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:spesa_sospesa/package_view.dart';
import 'package:spesa_sospesa/product.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(
    MediaQuery(data: MediaQueryData(), child: MaterialApp(home: MainApp())),
  );
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextStyle itemStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

  final Container customSep = Container(
    height: 5,
    margin: EdgeInsets.symmetric(vertical: 2),
    color: Colors.grey.withOpacity(0.1),
    //color: Colors.white,
  );

  Famiglie famiglia = Famiglie(
      "Bognoni Laura", 3, "3458494881", "Via delle querce 4", "Cesano boscone");

  List<Product> products = Product.createList(listaSpesa);

  bool consegnato = false;
  bool pacco = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: SafeArea(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "${famiglia.represante}",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "montserrat",
                    fontWeight: FontWeight.w600,
                    color:  Colors.blueGrey[600]
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                FaIcon(FontAwesomeIcons.male, size: 25, color:  Colors.blueGrey[300]),
                SizedBox(
                  width: 10,
                ),
                FaIcon(FontAwesomeIcons.male, size: 25, color:  Colors.blueGrey[300]),
                SizedBox(
                  width: 10,
                ),
                FaIcon(FontAwesomeIcons.male, size: 20, color:  Colors.blueGrey[300]),
                SizedBox(
                  width: 10,
                ),
                FaIcon(FontAwesomeIcons.baby, size: 20, color:  Colors.blueGrey[300]),
              ],
            )),
          ),
          Flexible(flex: 7, child: getBody(true))
        ],
      ),
    );
  }

  getBody(bool done) {
    if (pacco) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          InfoRow(famiglia.indirizzo, FontAwesomeIcons.mapMarkerAlt,
              onPress: () {

            MapsLauncher.launchQuery(
                '${famiglia.indirizzo}, ${famiglia.citta}');
          }),
          InfoRow(famiglia.citofono, FontAwesomeIcons.intercom),
          InfoRow(
            famiglia.telefono,
            FontAwesomeIcons.phone,
            onPress: () {
              launch('tel:// ${famiglia.telefono}');
            },
          ),
          Expanded(
              child: getBtn()
          )
        ],
      );
    }

    return Column(
      children: <Widget>[
        Expanded(
          flex: 14,
          child: PackageView(products, (int index) {
            setState(() {
              products[index].toggle();
            });
          }),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.redAccent[400].withOpacity(1),
                  ),
                  child: FlatButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        "Fatto",
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
    );
  }

 Consegnato getBtn() {
   return consegnato
        ? Consegnato(FontAwesomeIcons.check, Colors.white, Colors.white, Colors.green,)
        : Consegnato(FontAwesomeIcons.peopleCarry, Colors.blueGrey[100], Colors.white,  Colors.blueGrey[200], onPress: () => setState(() => consegnato = true));
  }
}

class Famiglie {
  final String represante;
  final int numeroMembri;
  final String telefono;
  final String indirizzo;
  final String citta;
  String _citofono;

  Famiglie(this.represante, this.numeroMembri, this.telefono, this.indirizzo,
      this.citta);

  String get citofono {
    return _citofono != null ? _citofono : represante;
  }
}

const List<String> listaSpesa = [
  "patate x 2",
  "passate pomodoro x 4",
  "scatole di latte x 3",
  "Cereali x 5",
  "pacco natale 1",
  "Riso x 4",
  "Riso x 4",
  "Pasta kili x 8",
  "Pasta kg x 8",
  "Pasta kg x 8",
  "patate x 2",
  "passate pomodoro x 4",
  "scatole di latte x 3",
  "Cereali x 5",
  "pacco natale 1",
  "Riso x 4",
  "Riso x 4",
  "Pasta kili x 8",
  "Pasta kg x 8",
  "Pasta kg x 8",
  "lentiche x 2",
  "Faggiolo x 5",
  "cecci x 5",
  "cipolla x 3",
  "passate pomodoro x 4",
  "scatole di latte x 3",
  "Cereali x 5",
  "pacco natale 1",
  "Riso x 4",
  "Riso x 4",
];

class rowElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
    );
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


class Consegnato extends StatelessWidget {
  final double extCircleSzie = 160.0;
  final double intCircleSize = 136;

  void Function() onPress;
  final IconData icon;
  final Color first;
  final Color second;
  final Color third;

  Consegnato(this.icon, this.first, this.second, this.third, {this.onPress}){
    if(this.onPress == null){
      onPress = (){};
    }
  }
  @override
  Widget build(BuildContext context) {

    return  Center(
      child: Container(
        height: extCircleSzie,
        width: extCircleSzie,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(extCircleSzie/2),
            border: Border.all(width: 5, color: first)
        ),
        child: Center(
          child: Container(
            height: intCircleSize,
            width: intCircleSize,
            decoration: BoxDecoration(
                color: second,
                borderRadius: BorderRadius.circular(intCircleSize/2),
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
                child:  FaIcon(icon, size: 50, color: third),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/**





    Text(
    "Consegnato",
    style: TextStyle(
    fontSize: 18,
    fontFamily: "montserrat",
    fontWeight: FontWeight.w600,
    color: third,
    //color: Colors.white
    ),
    )








    Expanded(
    flex: 2,
    child: Container(
    color: Colors.red,
    height: 150,
    child: SafeArea(
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
    Padding(
    padding:
    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Text(
    famiglia.represante,
    style: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w500,
    color: Colors.white),
    ),
    ),
    ]),
    ),
    ),
    ),










    Expanded(
    flex: 8,
    child: Padding(
    padding: EdgeInsets.only(
    top: 50,
    ),
    child: Column(
    children: <Widget>[
    customSep,
    ListTile(
    leading: FaIcon(FontAwesomeIcons.phone, color: Colors.blue),
    onTap: () => launch('tel:// ${famiglia.telefono}'),
    title: Text("3458494881", style: itemStyle),
    ),
    customSep,
    ListTile(
    leading: FaIcon(FontAwesomeIcons.city, color: Colors.blue),
    onTap: () =>
    launch('https://it.wikipedia.org/wiki/Cesano_Boscone'),
    title: Text(
    famiglia.citta,
    style: itemStyle,
    ),
    ),
    customSep,
    ListTile(
    leading: FaIcon(FontAwesomeIcons.mapMarkerAlt,
    color: Colors.blue),
    onTap: () => MapsLauncher.launchQuery(
    '${famiglia.indirizzo}, ${famiglia.citta}'),
    title: Text(
    famiglia.indirizzo,
    style: itemStyle,
    ),
    ),
    customSep,
    ListTile(
    leading:
    FaIcon(FontAwesomeIcons.intercom, color: Colors.blue),
    //onTap: () => MapLauncher. ('https://it.wikipedia.org/wiki/Cesano_Boscone'),
    title: Text(
    "uda",
    style: itemStyle,
    ),
    ),
    customSep,
    ],
    ),
    ),
    ),



    Container(

    child: Column(
    children: <Widget>[
    Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),

    ),
    child: FlatButton(
    onPressed: () { },
    child: Center(
    child: Text(
    "Fatto",
    style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20),
    ),
    ),
    ), /**/
    ),
    ],
    ),
    ),




    Consegnato





 **/
