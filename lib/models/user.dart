class Users {
 late String name;
 late String email;
  late String uid;
  late String password;

 Users({required this.name, required this.email,required String this.uid,required String this.password});
   // User();
 Users.fromMap(Map<String, dynamic> map){
   uid = map['uid'];
   name = map['name'];
   email = map['email'];
   password = map['password'];

 }

 Map<String, dynamic> toMap() {
   Map<String, dynamic> map = Map<String,dynamic>();
   map['name'] = name;
   map['uid'] = uid;
   map['email'] = email;
   map['password'] = password;

   return map;
 }

}
