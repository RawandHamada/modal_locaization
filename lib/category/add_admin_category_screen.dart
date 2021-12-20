
import 'package:flutter/material.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/models/category.dart';
import 'package:modal/utils/helpers.dart';
import 'package:modal/widgets/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddAdminCategoryScreen extends StatefulWidget {
  final  Category? category;
  AddAdminCategoryScreen(this.category);

  @override
  _AddAdminCategoryScreenState createState() => _AddAdminCategoryScreenState();
}

class _AddAdminCategoryScreenState extends State<AddAdminCategoryScreen>  with Helpers {
  late TextEditingController _titleTextController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xBF107AAA),
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.addcategories,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          AppTextField(
            hint:  AppLocalizations.of(context)!.titleCategory,
            controller: _titleTextController,
          ),

          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async => await performSave(),
            child: Text(AppLocalizations.of(context)!.addcategories),
            style: ElevatedButton.styleFrom(
              primary: Color(0xBF107AAA),
              minimumSize: Size(double.infinity, 50),
            ),
          ),

        ],
      ),
    );
  }


  Future<void> performSave() async {
    if (checkData()) {
        await save();

    }
  }

  bool checkData() {
    if (_titleTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, content: 'Enter required data', error: true);
    return false;
  }

  Future<void> save() async {
    bool status = await FbFirestoreController().CreateCategory(category: category);
    if (status) {
      showSnackBar(context: context, content: 'category saved successfully');
    //  clear();
    }
  }


  Category get category {
    Category categorys = Category();
    categorys.title = _titleTextController.text;
    return categorys;
  }

  void clear() {
    _titleTextController.text = '';
  }



}
