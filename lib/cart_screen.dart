import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/models/products.dart';
import 'package:modal/responsive/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CartScreen extends StatefulWidget {
  Products? products;
  CartScreen(this.products);
//  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.72).designHeight(8.12).init(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Color(0xBF107AAA),
          title: Text(AppLocalizations.of(context)!.myCart, style: TextStyle(fontFamily: 'Cairo',
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold),),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FbFirestoreController().readProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> data = snapshot.data!.docs;
              return ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          data[index].get('imagePath'),)),
                    title: Text(data[index].get('name'),),
                    subtitle: Text(data[index].get('price')),
                    onTap: () {

                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {},
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
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

        )


    );
  }
}
