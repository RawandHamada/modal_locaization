import 'package:flutter/material.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/models/category.dart';
import 'package:modal/utils/helpers.dart';
import 'package:modal/widgets/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class UpdateCategoryScreen extends StatefulWidget {
  final Category? category;
  UpdateCategoryScreen({this.category});

  @override
  _UpdateCategoryScreenState createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> with Helpers{

  late TextEditingController _titleTextController;
  late List<dynamic> listCategory = ['مطبخ تركي'];



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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xBF107AAA),
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.updateCategories,
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
            hint: AppLocalizations.of(context)!.titleCategory,
            controller: _titleTextController,
          ),

          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async => await performUpdate(),
            child: Text(AppLocalizations.of(context)!.updateCategories),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),)],),);
  }

  Future<void> performUpdate() async {
    await update();
  }


  Future<void> update() async {
    bool status = await FbFirestoreController().updateArray(nameDoc: 'categories', nameArray: 'categoryName'
        ,data: listCategory);
    if (status) {
      showSnackBar(context: context, content: 'category update successfully');
      Navigator.pop(context);
    }
  }



}
