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

  bool get added{
    return _added;
  }

  void toggle(){
    _added = !added;
  }
}


enum measure{
  Kg,
  Pz
}