import 'package:flutter/cupertino.dart';
import 'package:spesa_sospesa/family.dart';
import 'package:spesa_sospesa/product.dart';
import 'package:spesa_sospesa/shoping_bucket.dart';

class AppSession extends ChangeNotifier{

  final List<Family> family  = [
    Family(
        name: "Bogoni Laura",
        adults: 1,
        boys: 0,
        baby: 0,
        phone: "3478955772",
        address: "Via Libertà,30",
        city: "Cesano Boscone"
    ),

    Family(
        name: "Maringelli Massimiliano",
        adults: 2,
        boys: 2,
        baby: 0,
        phone: "3911340962",
        address: "Via delle acacie,12",
        city: "Cesano Boscone"
    ),

    Family(
        name: "Vasta Maria",
        adults: 3,
        boys: 0,
        baby: 0,
        phone: "3478955772",
        address: "Via Cellini 26",
        city: "Cesano Boscone"
    ),

    Family(
        name: "Putignano Davide",
        adults: 2,
        boys: 0,
        baby: 2,
        phone: "3478955772",
        address: "Via Cellini 26",
        city: "Cesano Boscone"
    ),
  ];


  List<ShoppingBucket> bucketList = [
    ShoppingBucket(
      owner: "Bogoni Laura",
      state: DeliverState.packaging,
      bucket: Product.createList(list)
    ),
    ShoppingBucket(
      owner: "Maringelli Massimiliano",
      state: DeliverState.packaging,
      bucket: Product.createList(list)
    ),
    ShoppingBucket(
      owner: "Vasta Maria",
      state: DeliverState.packaging,
      bucket: Product.createList(list)
    ),
    ShoppingBucket(
      owner: "Putignano Davide",
      state: DeliverState.packaging,
      bucket: Product.createList(list)
    )
  ];


  static  final List<String> list = [
  "OLIO pz 1",
  "RISO pz 1",
  "PASSATA pz 2",
  "CECI pz 1",

  ];


  ShoppingBucket currfamilyBucket;

  ShoppingBucket getBucketByOwner(String owner) {

    for(ShoppingBucket bucket in bucketList){
      if(bucket.owner == owner){
        return bucket;
      }
    }

    return null;
  }




  void saveByBucket(ShoppingBucket bucket) {

   /** for(int i = 0; i <bucketList.length; i++){
      if(bucket.owner == bucket.owner){
         bucketList[i] = bucket;
      }
    }**/
    notifyListeners();
  }

  getStateByOwner(String owner) {
    return getBucketByOwner(owner).state;
  }

}

/**
    "LENTICCHIE pz 1",
    "FAGIOLI pz 1",
    "PISELLI pz 0",
    "TONNO pz 5",
    "CARNE IN SCATOLA pz 2",
    "FORMAGGI pz 3",
    "LATTE pz 4",
    "ZUCCHERO pz 3",
    "CAFFE pz 1",
    "MARMELLATA/NUTELLA pz 2",
    "BISCOTTI pz 3",
    "PAN BAULETTO pz 2",
    "FETTE BISCOTTATE pz 1",
    "BRIOCHE pz 1",
    "PASTA kg 8",
    "BIBITE pz 3",
    "OMOGENEIZZATI pz 1",
    "CREME pz 1",
    "NEONATI",
    "ALTRO"
**/