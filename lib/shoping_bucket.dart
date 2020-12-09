import 'package:flutter/cupertino.dart';
import 'package:spesa_sospesa/product.dart';


const String PACKAGING = "packaging";
const String PACKAGED = "packaged";
const String DELIVERING = "delivering";
const String  DELIVERED = "delivered";
class ShoppingBucket {

  final String owner;
  String _state;
  final List<Product> bucket;

  ShoppingBucket({@required this.owner, @required String state , @required this.bucket}){
    this._state = state;
  }

  void nextState(){

    if(_state == PACKAGING){

      _state = PACKAGED;
    }else  if(_state == PACKAGED){

      _state = DELIVERING;
    }else  if(_state == DELIVERING){

      _state = DELIVERED;
    }else{
      _state = PACKAGING;
    }
  }

  void previousState() {

    if(_state == DELIVERED){

      _state = DELIVERING;
    }else if(_state == DELIVERING){

      _state = PACKAGED;
    }else  if(_state == PACKAGED){

      _state = PACKAGING;
    }

  }


  String get state{
    return _state;
  }


}


enum DeliverState{
  packaging,
  packaged,
  delivering,
  delivered
}
