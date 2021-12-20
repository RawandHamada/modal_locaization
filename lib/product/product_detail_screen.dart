import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/models/products.dart';
import 'package:modal/utils/helpers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetail extends StatefulWidget {
  Products _products;
  ProductDetail(this._products);


  @override
  _ProductDetailState createState() => _ProductDetailState(_products);
}

class _ProductDetailState extends State<ProductDetail> with Helpers{
  late Products _products;
  _ProductDetailState(this._products);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xBF107AAA),
        elevation: 0,
        title:  Text( AppLocalizations.of(context)!.productsDetail
          , style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 375,
                  width: 400,
                  child: Image.network(
                    _products.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(child: FloatingActionButton(
                    elevation: 2,
                   child:Image.asset("images/heart_icon_disabled.png",
                  width: 30,
                  height: 30,),
                  backgroundColor: Colors.white,
                  onPressed: (){}
                 ),
                  bottom: 10,
                  right: 20,
                ),
              ],
            ),
            Container(
              height: 300,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text( _products.name,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Cairo'),),
                    Text( _products.description,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,fontFamily: 'Cairo'),),
                    Text( _products.price,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.red),),
                   Text( _products.titleCategory,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.blueGrey),),
                    ElevatedButton(onPressed: () {
                      showSnackBar(context: context, content: 'تم اضافة المنتج الى السلة');
                      Navigator.pop(context);


                    },
                      child: Text(AppLocalizations.of(context)!.addtocart,style: TextStyle(
                          fontSize: 18, color: Colors.white,),),
                       style: ElevatedButton.styleFrom(
                      primary: Color(0xBF107AAA),
                      minimumSize: Size(double.infinity, 50)),),
                  ],
                ),

              ),
            )
          ],
        ),
      ),

    );
  }
  Future<void> update () async{
    await updateProduct(path: _products.path, products: _products);
    Navigator.pop(context);

  }

  Future<void> updateProduct({required String path,required Products products}) async {
    bool status = await FbFirestoreController().updateProduct(path: path,products: products);
    if (status) {
      showSnackBar(context: context, content: 'Product Updated Successfully');
    }
  }
}
/**
 *
 *   Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Text( AppLocalizations.of(context)!.productName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
    SizedBox(width: 5,),
    Text( _products.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
    ],
    ),
    SizedBox(height: 20,),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Text( AppLocalizations.of(context)!.price,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
    SizedBox(width: 5,),
    Text( _products.price,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
    ],
    ),
    SizedBox(height: 20,),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Text( AppLocalizations.of(context)!.description,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
    SizedBox(width: 20,),
    Text( _products.description,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
    ],
    ),
    SizedBox(height: 20,),
    ElevatedButton(onPressed: () async => await update()
    , child: Text(AppLocalizations.of(context)!.addtocart,style: TextStyle(
    fontSize: 16,
    color: Colors.white,
    ),),
    style: ElevatedButton.styleFrom(
    primary: Color(0xFF4B53F5),
    minimumSize: Size(double.infinity, 50)
    ),
    )
 *
 * */