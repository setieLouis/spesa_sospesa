import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spesa_sospesa/product.dart';

class PackageView extends StatelessWidget {

  final List<Widget> containers = [];
  PackageView(List<Product> products , Function addToggle){

    for(int i = 0; i < products.length; i++){
      Product p = products[i];
      containers.add(
          Container(
            margin: EdgeInsets.all(5),
            child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              onPressed: () => addToggle(i),
              child: Container(
                width: 150,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: getColor(p.added),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    p.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
      );
    }
  }

  Color getColor(bool added) {
      if(added)
        return  Colors.green[500];
      return Colors.blueGrey[500];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: containers,
          ),
        ),
      );
  }

}
