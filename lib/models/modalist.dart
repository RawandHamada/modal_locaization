class Modalist{

  late String path;
  late String title;
  late String content;

  Modalist();

  Modalist.fromMap(Map<String, dynamic> map){
    title = map['title'];
    content = map['content'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String,dynamic>();
    map['title'] = title;
    map['content'] = content;
    return map;
  }

}