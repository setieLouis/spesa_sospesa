import 'package:flutter/cupertino.dart';
import 'package:spesa_sospesa/product.dart';
import 'package:spesa_sospesa/shoping_bucket.dart';


/// the following attribute define old interval
/// adults = [18, +00)
/// boys = [8 , 16]
/// baby = [0 , 8]

class FamilyMap{

  final String familyId;
  final Family family;


  FamilyMap({ @required this.familyId, @required this.family });

}

class Family{

  /// FAMILY INFO
  final String name;
  final int adults;
  final int boys;
  final int baby;
  final String phone;
  final String address;
  final String city;

  /// can assume the following values
  ///   packaging,
  ///   packaged,
  ///   delivering,
  ///   delivered
  ///   we dont use enum for time
  ///
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
    @required   this.state,
  });


  String get intercom {
    return _intercom != null? _intercom : name;
  }

  static Family createFamily(Map<String, dynamic> map){
    return Family(
      name: map["name"],
      adults: map["adults"],
      boys: map["boys"],
      baby: map["baby"],
      phone: map["phone"],
      address: map["address"],
      city: map["city"],
      state : map["state"],
    );
  }
}