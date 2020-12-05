class Product {
  String _element;
  bool _added;




  static List<Product> createList(List<String> elements ){
      return elements.map((e) => create(e)).toList();
  }

  static Product create(String element ){
      Product product = new Product();
      product._element = element;
      product._added = false;

      return product;
  }

  String get element{
    return _element;
  }

  String toString(){

    String firstPart = "";
    String secondPart = "";

    if(_element.contains("pz")){
       firstPart = _element.substring(0, _element.indexOf("pz") - 1);
       secondPart = _element.substring(_element.indexOf("pz") - 1);

    }else if(_element.contains("kg")){
      firstPart = _element.substring(0, _element.indexOf("kg") - 1);
      secondPart = _element.substring(_element.indexOf("kg") - 1);
    }

    if(firstPart.length > 12) {
      firstPart = firstPart.substring(0, 12);
    }

    

    return firstPart + secondPart;
  }

  bool get added{
    return _added;
  }

  void toggle(){
    _added = !added;
  }

  getSpace(double index) {
    String space ="";
    for(int i = 0; i < index; i++){
      space +=" ";
    }

    return space;
  }
}


enum Measure{
  Kg,
  Pz
}