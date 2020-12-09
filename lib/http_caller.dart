import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const String  base = "https://lootbill-b7b1d.firebaseio.com" ;
const String  spesaSospesa = "spesasospesa";
const String  familyCollection = "family" ;
const String  bucketCollection = "bucket" ;
class HttpCaller {

  static final HttpCaller _httpCaller =   HttpCaller._internal();

  HttpCaller._internal();

  factory HttpCaller(){
    return _httpCaller;
  }


  Future<Map<String, dynamic>> allFamily() async {

     return   json.decode(await httpGet("$base/$spesaSospesa/$familyCollection.json"));
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

}
