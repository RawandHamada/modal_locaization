
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal/firebase/fb_auth_controller.dart';
import 'package:modal/models/category.dart';
import 'package:modal/models/modalist.dart';
import 'package:modal/models/products.dart';
import 'package:modal/models/carts.dart';
import 'package:modal/models/user.dart';

class FbFirestoreController{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final String _collectionUser = 'User';
  final String _collectionCategory = 'Category';
  final String _collectionProduct = 'Product';
  final String _collectionCart = 'cart';


  // Carts  Firestore  Controller

  Future<bool> CreateCarts({required Carts carts,required String collectionName}) async{
    return await _firebaseFirestore.collection(_collectionCart)
        .add(carts.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  Stream<QuerySnapshot> getCart() async*{
    yield* _firebaseFirestore.collection(_collectionCart).snapshots();
  }

  Stream<QuerySnapshot> readCart({required String collection}) async* {
    yield* _firebaseFirestore.collection('cart').snapshots();
  }

  Stream<QuerySnapshot> read({required String collection}) async* {
    yield* _firebaseFirestore.collection('Category').snapshots();
  }
  // Category  Firestore  Controller
  Future<bool> CreateCategory({required Category category}) async{
    return await _firebaseFirestore.collection(_collectionCategory)
        .add(category.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  Stream<QuerySnapshot> getCategory() async*{
    yield* _firebaseFirestore.collection(_collectionCategory).snapshots();
  }
  Future<bool> updateCategory({required String path,required Category category}) async{
    return await _firebaseFirestore.collection(_collectionCategory)
        .doc(path).update(category.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> readArray({required String nameCollection  }) async* {
    yield* _firebaseFirestore.collection('Category').snapshots();
  }


  Future<List<dynamic>> getArray(
      {required String nameArray}) async {
    List<dynamic> array = <dynamic>[];
    final DocumentReference document =
    _firebaseFirestore.collection('Category').doc('categories');
    await document.get().then<List<dynamic>>((DocumentSnapshot snapshot) async {
      List.from(snapshot.get(nameArray)).forEach((element) {
        String data = (element);
        array.add(data);
      });
      return array;
    });
    return array;
  }

  Future<bool> updateArray(
      {required String nameDoc,
        required String nameArray,
        required List<dynamic> data}) async {
    return await _firebaseFirestore
        .collection('Category')
        .doc('categories')
        .update({nameArray: FieldValue.arrayUnion(data)})
        .then((value) => true)
        .catchError((error) => false);
        }


       Future<bool> deleteFromArray(
          {required String nameDoc,
            required String nameArray,
            required List<dynamic> data}) async {
        return await _firebaseFirestore
            .collection('Category')
            .doc('categories')
            .update({nameArray: FieldValue.arrayRemove(data)})
            .then((value) => true)
            .catchError((error) => false);
  }

  Future<bool> deleteCategory({required String path}) async{
    return await _firebaseFirestore.collection(_collectionCategory)
        .doc(path).delete()
        .then((value) => true)
        .catchError((error) => false);
  }



//   Firestore  Product
  Stream<QuerySnapshot> readProduct() async* {
    yield* _firebaseFirestore.collection('Product').orderBy('name').snapshots();
  }
  //   Firestore  Product
  Future<bool> CreateProduct({required Products products, required String collectionName  }) async{
    return await _firebaseFirestore.collection(_collectionProduct)
        .add(products.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  //   Firestore  Product
  Stream<QuerySnapshot> getProduct() async*{
    yield* _firebaseFirestore.collection(_collectionProduct).snapshots();
  }
  //   Firestore  Product
  Future<bool> updateProduct({required String path,required Products products}) async{
    return await _firebaseFirestore.collection(_collectionProduct)
        .doc(path).update(products.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  //   Firestore  Product
  Future<bool> deleteProduct({required String path}) async{
    return await _firebaseFirestore.collection(_collectionProduct)
        .doc(path).delete()
        .then((value) => true)
        .catchError((error) => false);
  }



  //   Firestore  User
  Stream<QuerySnapshot> getUserData({required String  uid}) async*{
    yield* _firebaseFirestore.collection(_collectionUser).snapshots();
  }
  //   Firestore  User
  Future<bool> CreateUserData(BuildContext context,{required Users user}) async{
    FbAuthController().signIn(context, email: user.email, password: user.password);
    user.uid = FbAuthController().getCurrentUserId();
    return await _firebaseFirestore.collection(_collectionUser)
        .add(user.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  //   Firestore  User

  Future<bool> updateUserData({required String path,required Users user}) async{
    return await _firebaseFirestore.collection(_collectionUser)
        .doc(path).update(user.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  //   Firestore  User

  Future<bool> deleteUserData({required String path}) async{
    return await _firebaseFirestore.collection(_collectionUser)
        .doc(path).delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  //   Firestore  list info modal

  Future<bool> createlistModal({required Modalist modalist}) async {
    return await _firebaseFirestore
        .collection('ListInfo')
        .add(modalist.toMap())
        .then((value) {
      print('ID: ${value.id}');
      return true;
    }).catchError((error) {
      print(error);
      return false;
    });
  }

  Stream<QuerySnapshot> readlistModal() async* {
    yield* _firebaseFirestore.collection('ListInfo').orderBy('title').snapshots();
  }

  Future<bool> updatelistModal({required String path, required Modalist modalist}) async {
    return await _firebaseFirestore
        .collection('ListInfo')
        .doc(path)
        .update(modalist.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deletelistModal({required String path}) async {
    return await _firebaseFirestore
        .collection('ListInfo')
        .doc(path)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

}

