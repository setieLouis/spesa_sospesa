import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spesa_sospesa/Helper.dart';
import 'package:spesa_sospesa/add_helper.dart';
import 'package:spesa_sospesa/family.dart';
import 'package:spesa_sospesa/http_caller.dart';

import 'app_session.dart';
import 'custom_btn.dart';

class AddFamilyView extends StatefulWidget {

  final HelperMap helperMap;
  final Function afterSave;
  final String title;

  AddFamilyView({this.helperMap, this.afterSave, @required this.title});

  @override
  _AddFamilyViewState createState() => _AddFamilyViewState();
}

List<String> helpers = [
  "Setie Louis Adjambri",
  "Mario Cimmino",
  "Cate Galotti",
  "Luisa",
  "Federica",
  "Matteo",
  "Francesca",
  "Setie Louis Adjambri",
  "Mario Cimmino",
  "Cate Galotti",
  "Luisa",
  "Federica",
  "Matteo",
  "Francesca",
];

class _AddFamilyViewState extends State<AddFamilyView> {
  Map<String, dynamic> map = Map();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController intercomController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController boysController = TextEditingController();
  TextEditingController babyController = TextEditingController();
  TextEditingController helperController = TextEditingController();
  String selected;

  HttpCaller _httpCaller = HttpCaller();
  List<HelperMap> helperMap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.helperMap != null && widget.helperMap.helper != null) {
      Helper helper = widget.helperMap.helper;
      nameController.text = helper.name;
      phoneController.text = helper.phone;
      print("=================================== ${helper
          .role}========================================");
      roleController.text = helper.role;

      selected = widget.helperMap.key;
    }
  }



  @override
  void dispose() {
    super.dispose();
    //nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formakey = GlobalKey<FormState>();

    return ChangeNotifierProvider(
      create: (context) => AppSession(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SafeArea(
                  child: Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: FaIcon(Icons.clear,
                          size: 30, color: Colors.blueGrey[300])),

                  Expanded(
                    child: Center(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "montserrat",
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey[600]),
                      ),
                    ),
                  ),

                  getDelete()
                ],
              )),
            ),
            Expanded(
              flex: 10,
              child: Center(
                child: Form(
                  key: formakey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextInput(
                            controller: nameController,
                            label: 'Name *',
                            validator: (value) => stringValidator(value),
                            onSave: (value) => map[NAME] = value
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextInput(
                            controller: phoneController,
                            label: 'Phone Number *',
                            validator: (value) => phoneValidator(value),
                            onSave: (value) => map[PHONE] = value),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextInput(
                          controller: roleController,
                          readOnly: true,
                          label: 'Role',
                          onTap: helper,
                          onSave: (value) {
                            map["role"] = value;
                          },
                          validator: (value) => null,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              child: CustomBtn(
                  icon: FontAwesomeIcons.solidPaperPlane,
                  height: 80,
                  borderColor: Colors.white,
                  background: Colors.green[400],
                  iconColor: Colors.white,
                  onPress: () async {
                    if (formakey.currentState.validate()) {
                      formakey.currentState.save();

                      await _httpCaller.updateHelper(
                          map, widget.helperMap != null
                          ? widget.helperMap.key
                          : null
                      );

                      if (widget.afterSave != null) {
                        widget.afterSave();
                      }
                    }


                  }),
            )
          ],
        ),
      ),
    );
  }


  void helper() async{
    if (helperMap == null) {
      helperMap = await _httpCaller.allHelper();
    }

    List<String> helperName = ["Admin", "helper"];
    /**for(HelperMap helper in helperMap){
        helperName.add(helper.helper.name);
        }**/


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OptionView(
              helperName,
                  (int index) {
                setState(() {
                  roleController.text = helperName[index];
                });
                Navigator.pop(context);
              },
            ),
      ),
    );
  }
  void onSave(String input, String fieldName, int defaultValue) {
    int value = 0;

    if (input != null && input.trim().isNotEmpty) {
      value = int.parse(input);
    } else {
      value = defaultValue;
    }

    map[fieldName] = value;
  }

  String numberValidator(String value) {
    if (value.isNotEmpty && int.tryParse(value) == null) {
      return "this field have tobe a number";
    }

    return null;
  }

  String phoneValidator(String value) {
    if (value == null || value.trim().isEmpty) {
      return "this field is required";
    } else if (value == null ||
        value.length < 6 ||
        value.length > 11 ||
        int.tryParse(value) == null) {
      return "this field have tobe a phone number";
    }

    return null;
  }

  String stringValidator(String value) {
    if (value.isEmpty || (value.isNotEmpty && value.length < 5)) {
      return "this field must have less 5 characters";
    }

    return null;
  }

  Widget getDelete() {
    if (widget.helperMap != null) {
      return IconButton(
          onPressed: () async {
            await _httpCaller.deleteHelper(widget.helperMap.key);
            widget.afterSave();
          },
          icon: FaIcon(Icons.delete,
              size: 30, color: Colors.blueGrey[300]));
    }

    return Container();

  }
}

class CustomTextInput extends StatelessWidget {

  final String label;
  final Function(String value) validator;
  final Function(String value) onSave;
  TextEditingController controller;
  Function onTap;
  bool readOnly;

  CustomTextInput(
      {TextEditingController controller,
      Function onTap,
        this.readOnly = false,

      @required this.label,
      @required this.validator,
      @required this.onSave
      }) {
    this.controller = controller == null ? TextEditingController() : controller;
    this.onTap = onTap == null ? () {} : onTap;
  }

//onEditingComplete
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        controller: this.controller,
        onTap: onTap,
        readOnly: readOnly,
        //onEditingComplete: (value) => onChange(value),
        style: TextStyle(
            color: Colors.blueGrey[700],
            fontWeight: FontWeight.w500,
            fontSize: 16),
        decoration: InputDecoration(
            labelText: label,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[400])),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            border: OutlineInputBorder()),
        validator: (value) => validator(value),
        onSaved: (value) => onSave(value),
      ),
    );
  }
}


/**



    Container(
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: TextFormField(
    readOnly: true,
    initialValue: helper,

    style: TextStyle(color: Colors.blueGrey[700]),
    decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: Colors.blueGrey[400])),
    errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red)),
    border: OutlineInputBorder()),
    ),
    )
**/