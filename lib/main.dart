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
      "Bognoni Laura", 3, "3458494881", "via delle querce 4", "Cesano boscone");

  List<Product> products = Product.createList(listaSpesa);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.red,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    famiglia.represante,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  FaIcon(FontAwesomeIcons.phone,
                                      size: 18, color: Colors.white),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    famiglia.telefono,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ]),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                FaIcon(FontAwesomeIcons.mapMarkerAlt,
                                    size: 20, color: Colors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  famiglia.indirizzo,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  FaIcon(FontAwesomeIcons.city,
                                      size: 20, color: Colors.white),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    famiglia.citta,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ]),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                FaIcon(FontAwesomeIcons.intercom,
                                    size: 20, color: Colors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  famiglia.citofono,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: Column(
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
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
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

/**
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














**/
