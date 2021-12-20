import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/firebase/fb_storage_controller.dart';
import 'package:modal/models/products.dart';
import 'package:modal/utils/helpers.dart';
import 'package:modal/widgets/app_text_field.dart';

class AddProductsScreen extends StatefulWidget {
  final Products? products;

  AddProductsScreen(this.products);

  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> with Helpers {
  late TextEditingController productsName;
  late TextEditingController description;
  late TextEditingController price;
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late String url;
  late List<dynamic> listCategory = ['مطبخ تركي'];
  var category;
  //late String nameGetArray;

  @override
  void initState() {
    // TODO: implement initState
    productsName = TextEditingController();
    description = TextEditingController();
    price = TextEditingController();
    getList(nameGetArray: 'categoryName');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    productsName.dispose();
    description.dispose();
    price.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xBF107AAA),
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.addproducts,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        color: Colors.black.withOpacity(0.61),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      child: pickedImage != null
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FileImage(
                                    File(pickedImage!.path),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)!.addimage,
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.productName,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            AppTextField(
                hint: AppLocalizations.of(context)!.productName,
                controller: productsName),
            SizedBox(height: 20),
            Text(
              'صنف ل',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            Card(
              elevation: 2,
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
                value: category,
                onChanged: (newValue) {
                  setState(() {
                    category = newValue.toString();
                  });
                },
                items: listCategory.map<DropdownMenuItem<dynamic>>((var value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.description,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            AppTextField(
                hint: AppLocalizations.of(context)!.description,
                controller: description),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.price,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            AppTextField(
              hint: AppLocalizations.of(context)!.price,
              controller: price,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:Color(0xBF107AAA),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.save,
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () async {
                if (await performAddProducts()) {
                  Navigator.pop(context);
                } else {
                  showSnackBar(
                      context: context,
                      content: 'error in add products',
                      error: true);
                }
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:Color(0xBF107AAA),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: _currentValue,
            ),
          ]),
    );
  }

  Future<bool> performAddProducts() async {
    if (checkData()) {
      await FbFirestoreController().CreateProduct(products: products, collectionName: 'Product');

      return true;
    }
    return false;
  }

  bool checkData() {
    if (productsName.text.isNotEmpty &&
        price.text.isNotEmpty &&
        description.text.isNotEmpty) {
      if (pickedImage != null) {
        return true;
      }
      return false;
    }
    showSnackBar(
        context: context, content: 'please enter required data', error: true);
    return false;
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      pickImageGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    pickImageCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> pickImageCamera() async {
    pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 25);
    if (pickedImage != null) {
      setState(() {});
      uploadImage();
    }
  }

  Future<void> pickImageGallery() async {
    pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);
    if (pickedImage != null) {
      setState(() {});
      uploadImage();
    }
  }

  void uploadImage() {
    _currentValue = null;
    if (pickedImage != null) {
      FbStorageController().upload(
        pickedFile: File(pickedImage!.path),
        eventsHandler: (bool status, String message, TaskState state,
            {Reference? reference}) async {
          if (status) {
            showSnackBar(context: context, content: message);
            changeCurrentIndicator(1);
            downloadURLExample(reference: reference);
          } else {
            if (status == TaskState.running) {
              print('The running Downloader ');
              changeCurrentIndicator(0);
            } else {
              // showSnackBar(context: context, content: message, error: true);
              changeCurrentIndicator(null);
            }
          }
        },
      );
    } else {
      showSnackBar(
          context: context, content: 'Pick image to upload', error: true);
    }
  }

  void changeCurrentIndicator(double? currentIndicator) {
    setState(() {
      _currentValue = currentIndicator;
    });
  }

  Future<void> downloadURLExample({Reference? reference}) async {
    url = await reference!.getDownloadURL();
  }

  Products get products {
    Products products = Products();
    products.name = productsName.text;
    products.description = description.text;
    products.price = price.text;
    products.imagePath = url;
    products.titleCategory= category.toString();
    return products;
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
