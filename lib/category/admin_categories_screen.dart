import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal/category/add_category_screen.dart';
import 'package:modal/category/update_category_screen.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/models/category.dart';
import 'package:modal/utils/helpers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class AdminCategoriesScreen extends StatefulWidget {


  @override
  _AdminCategoriesScreenState createState() => _AdminCategoriesScreenState();
}

class _AdminCategoriesScreenState extends State<AdminCategoriesScreen> with Helpers{
  late Category _category;
  late String url;
  late List<dynamic> listCategory = ['مطبخ تركي'];
  var category;
  @override
  void initState() {
    // TODO: implement initState
    getList(nameGetArray: 'categoryName');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xBF107AAA),
        title: Text( AppLocalizations.of(context)!.categories,style: TextStyle(color: Colors.white),),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FbFirestoreController().readArray(nameCollection:'Category'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<QueryDocumentSnapshot> data1 = snapshot.data!.docs;
            return ListView.separated(
              itemCount: listCategory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.title),
                  title: Text(listCategory[index]),
                  onTap: () {

                  },
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      Category categorys = Category();
                      categorys.idcat = data1[index].id;
                      categorys.title = data1[index].get('title');
                     await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateCategoryScreen(category: categorys,)));
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
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
      ) ,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xBF107AAA),
          onPressed: () {
            Category category = Category();
            category.title = '';
          //  category.content='';
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCategoryScreen(category)));
          },
          child: Icon(Icons.add),
        ),
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
