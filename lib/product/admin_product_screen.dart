import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/models/products.dart';
import 'package:modal/product/add_products_screen.dart';
import 'package:modal/product/product_detail_screen.dart';
import 'package:modal/product/update_products_screen.dart';
import 'package:modal/utils/helpers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AdminProductScreen extends StatefulWidget {
  const AdminProductScreen({Key? key}) : super(key: key);

  @override
  _AdminProductScreenState createState() => _AdminProductScreenState();
}

class _AdminProductScreenState extends State<AdminProductScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xBF107AAA),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(AppLocalizations.of(context)!.product,
          style: TextStyle(color: Colors.white),),

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FbFirestoreController().readProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<QueryDocumentSnapshot> data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 157 / 190),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              Container(
                                height: 100,
                                width: 120,
                                child: Image.network(
                                  data[index].get('imagePath'),
                                  fit: BoxFit.cover,

                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                data[index].get('name'),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data[index].get('price'),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        Products prodacts = Products();
                                        prodacts.path = data[index].id;
                                        prodacts.name = data[index].get('name');
                                        prodacts.description = data[index].get('description');
                                        prodacts.imagePath = data[index].get('imagePath');
                                        prodacts.price = data[index].get('price');
                                        prodacts.titleCategory = data[index].get('titleCategory');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => UpdateProductsScreen(prodacts)));                                      },
                                      color: Colors.black,
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await deleteProducts(
                                            path: data[index].id);
                                      },
                                      color: Colors.red.shade900,
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      onTap: () {
                        Products prodacts = Products();
                        prodacts.path = data[index].id;
                        prodacts.name = data[index].get('name');
                        prodacts.description = data[index].get('description');
                        prodacts.imagePath = data[index].get('imagePath');
                        prodacts.price = data[index].get('price');
                        prodacts.titleCategory = data[index].get('titleCategory');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetail(prodacts)));
                      },
                    );
                  }),

            );
          }
          else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning, size: 85, color: Colors.grey.shade500),
                  Text(
                    'NO DATA',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xBF107AAA),
        onPressed: () {
          Products products = Products();
          products.name = '';
          products.description = '';
          products.price = '';
          products.imagePath = '';
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddProductsScreen(products)));
        },
        child: Icon(Icons.add),
      ),

    );
  }

  Future<void> deleteProducts({required String path}) async {
    bool status = await FbFirestoreController().deleteProduct(path: path);
    if (status) {
      showSnackBar(context: context, content: ' deleted successfully');
    }
  }
}
  /*Products getProducts(QueryDocumentSnapshot snapshot) {
    Products products = Products();
    products.imagePath = snapshot.id;
    products.name = snapshot.get('name');
    products.description = snapshot.get('description');
    products.price = snapshot.get('price');
    products.titleCategory = snapshot.get('titleCategory');
    return products;
  }*/

