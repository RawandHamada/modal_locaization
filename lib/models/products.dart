class   Products{
  late String path;
  late String imagePath;
  late String imageUrl;
  late String name;
  late String description;
  late String price;
  late String titleCategory;


  Products();
  Products.fromMap(Map<String, dynamic> map){
    name = map['name'];
    description = map['description'];
    imageUrl = map['imageUrl'];
    price = map['price'];
    imagePath = map['imagePath'];
    titleCategory = map['titleCategory'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String,dynamic>();
    map['name'] = name;
    map['imageUrl'] = imageUrl;
    map['description'] = description;
    map['price'] = price;
    map['imagePath'] = imagePath;
    map['titleCategory'] = titleCategory;

    return map;
  }
}