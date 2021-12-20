class Category {

  late String idcat;
  late String title;

  Category();

  Category.fromMap(Map<String, dynamic> map){
    title = map['title'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String,dynamic>();
    map['title'] = title;

    return map;
  }
}