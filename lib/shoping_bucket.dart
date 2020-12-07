import 'package:flutter/cupertino.dart';
import 'package:spesa_sospesa/product.dart';

class ShoppingBucket {

  final String owner;
  DeliverState _state;
  final List<Product> bucket;

  ShoppingBucket({@required this.owner, @required DeliverState state , @required this.bucket}){
    this._state = state;
  }

  void nextState(){

    if(_state == DeliverState.packaging){

      _state = DeliverState.packaged;
    }else  if(_state == DeliverState.packaged){

      _state = DeliverState.delivering;
    }else  if(_state == DeliverState.delivering){

      _state = DeliverState.delivered;
    }else{
      _state = DeliverState.packaging;
    }
  }

  void previousState() {

    if(_state == DeliverState.delivered){

      _state = DeliverState.delivering;
    }else if(_state == DeliverState.delivering){

      _state = DeliverState.packaged;
    }else  if(_state == DeliverState.packaged){

      _state = DeliverState.packaging;
    }

  }


  DeliverState get state{
    return _state;
  }


}


enum DeliverState{
  packaging,
  packaged,
  delivering,
  delivered
}
