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

    final string = "pz";
    final string1 = "kg";

    String firstPart = "";
    String secondPart = "";

    if(_element.contains(string)){
      List<String> response = split(_element, string);
      firstPart = response[0];
      secondPart = response[1];

    }else if(_element.contains(string1)){
      List<String> response = split(_element, string1);
      firstPart = response[0];
      secondPart = response[1];

    }else{
      firstPart = _element;
    }


    if(firstPart.length > 12) {
      firstPart = firstPart.substring(0, 12);
    }

    return firstPart + secondPart;
  }


  List<String> split(String element , String splitter){
    List<String> el = [];
    int index = element.indexOf(splitter);
    el.add(element.substring(0, index - 1));
    el.add(element.substring(index - 1));

     return el;
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