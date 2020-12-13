import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spesa_sospesa/family.dart';

import 'Helper.dart';

const String  base = 'https://lootbill-b7b1d.firebaseio.com' ;
const String  spesaSospesa = 'spesasospesa';
const String  familyCollection = 'family' ;
const String  helperCollection = 'helper' ;
const String  bucketCollection = 'bucket' ;
class HttpCaller {

  static final HttpCaller _httpCaller =   HttpCaller._internal();

  HttpCaller._internal();

  factory HttpCaller(){
    return _httpCaller;
  }


  Future<List<FamilyMap>> allFamily() async {

    Map<String, dynamic> map = json.decode(await httpGet("$base/$spesaSospesa/$familyCollection.json"));
    List<FamilyMap> families = [];

    for(String key in map.keys ){
      families.add(FamilyMap(
        familyId: key,
        family:  Family.createFamily(map[key]),
      ));

    }

     return families;
  }

  Future<List<HelperMap>> allHelper() async {

    Map<String, dynamic> map = json.decode(await httpGet("$base/$spesaSospesa/$helperCollection.json"));

    List<HelperMap>   hm = [];
    for(String key in map.keys ){
      hm.add(HelperMap(
        key: key,
        helper:  Helper.createHelper(map[key]),
      ));
      //families.add(FamilyMap(fm    key,));
    }
     return hm;
  }

  Future<List<dynamic>> familyBucket(String familyId) async {

    return json.decode(await  httpGet("$base/$spesaSospesa/$bucketCollection/$familyId.json"));
  }


  Future<String > httpGet(String url) async{

    print(url);

    final response =  await http.get(url);

    print(response.body);

    return response.body;

  }


  void updateFamily(Map<String, dynamic> body, String id) async {

    String url = '$base/$spesaSospesa/$familyCollection';

    if(id != null){

       url +='/$id.json';
       print(url);
       final resp1 =  await http.patch(url, body:  jsonEncode(body));
       print(resp1.body);
    }else{
      url +='.json';
      print(url);
      final resp2 =  await http.post(url, body:  jsonEncode(body));
      print(resp2.body);
    }
  }


  void delete(String id) async {

    String url = '$base/$spesaSospesa/$familyCollection/$id.json';

    print(url);

    await http.delete(url);

  }

}
