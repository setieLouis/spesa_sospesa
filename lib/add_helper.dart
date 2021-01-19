import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Helper.dart';
import 'custom_btn.dart';

class OptionView extends StatefulWidget {

  final List<String>  options;
  final Function(int) onPress;

  OptionView(this.options, this.onPress);

  @override
  _OptionViewState createState() => _OptionViewState();
}

class _OptionViewState extends State<OptionView> {

  List<String> tmpHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tmpHelper = widget.options;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400].withOpacity(1),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 0),
                  ),
                ]
            ),
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
                            onChanged: (value){
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
              ),),
          ),
          Expanded(
            flex: 9,
            child: Container(
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: getItem(),
                  ),

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void onSearch(String input){
    List<String> local = [];
    input = input.toLowerCase();

    if(input != null && input.trim().isNotEmpty){
      for(String h in widget.options){
        if(h.toLowerCase().contains(input)){
          local.add(h);
        }
      }
    }else{
      local = widget.options;
    }

    setState(() {
      tmpHelper = local;
    });

  }

  List<Widget> getItem(){
    List<Widget> container=[];
    for(int i = 0; i < tmpHelper.length; i++ ){
      String h = tmpHelper[i];
      container.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: CustomBtn(
            text: h,
            radius: 10,
            width: 350,
            height: 60,
            shadow: false,
            borderColor: Colors.white,
            background: Colors.blueGrey[400],
            iconColor: Colors.white,
            onPress: () => widget.onPress(i),
          ),
        ),
      );
    }

    return container;

  }

}



