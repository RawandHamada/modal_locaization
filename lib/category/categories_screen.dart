import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal/category/add_admin_category_screen.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/models/category.dart';
import 'package:modal/utils/helpers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}


class _CategoriesScreenState extends State<CategoriesScreen> with Helpers {
  late List<dynamic> listCategory = [''];
  @override
  void initState() {
    // TODO: implement initState
    getList(nameGetArray: 'categoryName');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FbFirestoreController().readArray(nameCollection: 'Category'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          List<QueryDocumentSnapshot> data1 = snapshot.data!.docs;
          return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.title),
                title: Text(listCategory[index]),
                onTap: () {

                },

              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: listCategory.length,
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning, size: 85, color: Colors.grey.shade500),
                Text(
                  AppLocalizations.of(context)!.nOCategories,
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
    );
  }
  Category getCategory(QueryDocumentSnapshot snapshot) {
    Category categorys = Category();
    categorys.idcat = snapshot.id;
    categorys.title = snapshot.get('title');
    return categorys;
  }
  void getList({required String nameGetArray}) async {
    // جلب بيانات الليست
    List selectList = (await FbFirestoreController()
        .getArray(nameArray: nameGetArray)) as List;
    if (selectList.isNotEmpty) {
      listCategory = selectList;
      setState(() {});
    }
  }

}

