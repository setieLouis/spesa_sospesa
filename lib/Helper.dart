import 'package:flutter/cupertino.dart';

import 'family.dart';



const String ROLE = 'role';

class HelperMap{
  String key;
  Helper helper;
  HelperMap({this.key, this.helper});
}


class Helper{

  String name;
  String phone;
  String role;

  Helper({@required this.name, @required this.phone, @required this.role});

  static Helper createHelper(Map<String, dynamic> map){
    return Helper(
      name: map[NAME],
      phone: map[PHONE],
      role: map[ROLE],
    );
  }
}