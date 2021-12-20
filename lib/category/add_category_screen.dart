
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/models/category.dart';
import 'package:modal/utils/helpers.dart';
import 'package:modal/widgets/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class AddCategoryScreen extends StatefulWidget {
  late Category? category;

  AddCategoryScreen(this.category);

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen>  with Helpers {
  late TextEditingController _titleTextController;
  var category;
  late List<dynamic> listCategory = ['مطبخ تركي'];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextController = TextEditingController();
    // _contentTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleTextController.dispose();
    // _contentTextController.dispose();
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
            hint: AppLocalizations.of(context)!.titleCategory,
            controller: _titleTextController,
          ),

          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async => await performSave(),
            child: Text( AppLocalizations.of(context)!.addcategories,),
            style: ElevatedButton.styleFrom(
              primary: Color(0xBF107AAA),
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        /*  Divider(
            height: 30,
            color: Colors.grey.shade500,
            thickness: 1,
          ),*/
        //  streamItem(),
        ],
      ),
    );
  }

  Future<void> performSave() async {
    await addInArray();
  }


  Future<void> addInArray() async {
    List<dynamic> list = <dynamic>[_titleTextController.text];
    bool state = await FbFirestoreController().updateArray(
        nameDoc: 'categories', nameArray: 'categoryName', data: list);
    if (state) {
      showSnackBar(context: context, content: 'تم اضافة الصنف  بنجاح');
    }
  }


  void clear() {
    _titleTextController.text = '';
  }

 Widget streamItem() {
    return StreamBuilder<QuerySnapshot>(
      stream: FbFirestoreController().readArray(
          nameCollection: 'Category'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          List<QueryDocumentSnapshot> data = snapshot.data!.docs;
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String id = data[index].id;
                List<String> listCategory = data[index].get('categories');
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                side:
                                BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(10))),
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: DropdownButton<dynamic>(
                          underline: SizedBox(),
                          autofocus: true,
                          isDense: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.black,
                          ),
                          iconSize: 28,
                          isExpanded: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          elevation: 3,
                          dropdownColor: Colors.white,
                          value: widget.category,
                          onChanged: (newValue) {
                            setState(() {
                              widget.category = newValue!;
                            });
                          },
                          items: listCategory.map<DropdownMenuItem<dynamic>>((
                              var value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (widget.category != 'إختر إسم الصنف') {
                              List<dynamic> nameDelete = <dynamic>[];
                              nameDelete.add(widget.category);
                              print(nameDelete);
                              bool delete = await FbFirestoreController()
                                  .deleteFromArray(nameDoc: 'categories',
                                  nameArray: 'categoryName',
                                  data: nameDelete);
                              if (delete) {
                                showSnackBar(
                                    context: context, content: 'تم الحذف');
                                setState(() {
                                  widget.category!.title ='اختر اسم الصنف' ;
                                });
                              } else {
                                showSnackBar(context: context,
                                    content: 'حدثت مشكلة أثناء الحذف',
                                    error: true);
                              }
                            } else {
                              showSnackBar(context: context,
                                  content: 'قم بإختيار شركة للحذف',
                                  error: true);
                            }
                          },
                          child: Text(
                            'حذف',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                            minimumSize: Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ))
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(color: Colors.grey.shade500);
              },
              itemCount: data.length);
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning, size: 85, color: Colors.grey.shade500),
                  Text(
                    'قم بالاضافة',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }}