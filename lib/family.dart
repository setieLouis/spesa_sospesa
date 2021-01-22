import 'package:flutter/cupertino.dart';


const String NAME = 'name';
const String ADULTS = 'adults';
const String BOYS = 'boys';
const String BABY = 'baby';
const String PHONE = 'phone';
const String ADDRESS = 'address';
const String CITY = 'city';
const String STATE = 'state';
const String INTERCOM = 'intercom';
const String HELPER = 'helper';
const String HELPERS = 'helpers';
const String HELPER_NAME = 'helpername';


class FamilyMap{

  final String familyId;
  final Family family;


  FamilyMap({ @required this.familyId, @required this.family });

}

class Family{

  /// FAMILY INFO
  String name;
  int adults;
  int boys;
  int baby;
  String phone;
  String address;
  final String city;
  final String helperCode;
  List<String> helpers;

  String state;

  String _intercom;

  Family({
    @required this.name,
    @required this.adults,
    @required this.boys,
    @required this.baby,
    @required this.phone,
    @required this.address,
    @required this.city,
    @required this.state,
    @required this.helperCode,
    this.helpers,
  });


  String get intercom {
    return _intercom != null? _intercom : name;
  }

  static Family createFamily(Map<String, dynamic> map){
    return Family(
      name: map[NAME],
      adults: map[ADULTS],
      boys: map[BOYS],
      baby: map[BABY],
      phone: map[PHONE],
      address: map[ADDRESS],
      city: map[CITY],
      state : map[STATE],
    );
  }


  static Map<String, dynamic> toJson(Family family){

    Map<String, dynamic> map = Map();
    map[NAME] = family.name;
    map[ADULTS] = family.adults;
    map[BOYS] = family.boys;
    map[BABY] = family.baby;
    map[PHONE] = family.phone;
    map[ADDRESS] = family.address;
    map[CITY] = family.city;
    map[STATE] = family.state;
    map[HELPERS] = family.helpers;

    return map;
  }
}