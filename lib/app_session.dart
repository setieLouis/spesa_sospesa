import 'package:flutter/cupertino.dart';
import 'package:spesa_sospesa/family.dart';
import 'package:spesa_sospesa/product.dart';
import 'package:spesa_sospesa/shoping_bucket.dart';

import 'http_caller.dart';

class AppSession extends ChangeNotifier{

  static final AppSession _appSession = AppSession._internal();

  /// Instance attributes
  final HttpCaller _httpCaller = HttpCaller();
  List<ShoppingBucket> _bucketList = [];
  List<FamilyMap> families = [];
  List<FamilyMap> allfamilies = [];
  ShoppingBucket currentBucket;

  /// Factory constructor
  AppSession._internal();

  factory AppSession(){
    return _appSession;
  }


  ShoppingBucket _haveBucket(String familyId){

    for(ShoppingBucket bucket in _bucketList){
      if(bucket.owner == familyId)
        return bucket;
    }

    return null;
  }


  static  final List<String> list = [
    "OLIO pz 1",
    "RISO pz 1",
    "PASSATA pz 2",
    "CECI pz 1",

  ];


  ShoppingBucket getBucketByOwner(String owner) {

    for(ShoppingBucket bucket in _bucketList){
      if(bucket.owner == owner){
        return bucket;
      }
    }

    return null;
  }




  void notify() {

    notifyListeners();
  }

  getStateByOwner(String familyId) {
    return familyBucket(familyId);
  }

  allFamily() async {

    families = await  _httpCaller.allFamily();

    notifyListeners();
  }


  Future<ShoppingBucket> familyBucket(String  familyId) async {

    ShoppingBucket tmp = _haveBucket(familyId);

    if(tmp == null){

      List<dynamic> list = await  _httpCaller.familyBucket(familyId) ;

      _bucketList.add (ShoppingBucket(
          owner: familyId,
          state: PACKAGING,
          bucket: Product.createListByDynamic(list)));

      tmp = _bucketList[_bucketList.length - 1];
    }

    return tmp;
  }

  void saveFamily(Map<String, dynamic> map, String id) {
      _httpCaller.updateFamily(map, null);
  }

}