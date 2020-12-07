import 'package:flutter/cupertino.dart';


/// the following attribute define old interval
/// adults = [18, +00)
/// boys = [8 , 16]
/// baby = [0 , 8]

class Family{

   final String name;
   final int adults;
   final int boys;
   final int baby;
   final String phone;
   final String address;
   final String city;
  String _intercom;

  Family({
    @required this.name,
    @required this.adults,
    @required this.boys,
    @required this.baby,
    @required this.phone,
    @required this.address,
    @required this.city,
  });

  String get intercom {
    return _intercom != null? _intercom : name;
  }
}