
  class Carts{
    late String imageProduct;
    late String idcart;
    late String nameProduct;


    Carts();

  Carts.fromMap(Map<String, dynamic> map){
      imageProduct = map['imageProduct'];
      nameProduct = map['nameProduct'];
    }

    Map<String, dynamic> toMap() {
      Map<String, dynamic> map = Map<String,dynamic>();
      map['imageProduct'] = imageProduct;
      map['nameProduct'] = nameProduct;
      return map;
    }

  }