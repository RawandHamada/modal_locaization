import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/firebase/fb_storage_controller.dart';
import 'package:modal/models/carts.dart';
import 'package:modal/utils/helpers.dart';

class AddedImageScreen extends StatefulWidget {
  const AddedImageScreen({Key? key}) : super(key: key);

  @override
  _AddedImageScreenState createState() => _AddedImageScreenState();
}

class _AddedImageScreenState extends State<AddedImageScreen> with Helpers {
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add Images ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),),
      body:    Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.white70.withOpacity(0.61),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  showPicker(context);
                },
                child: Container(
                  width: 300,
                  height: 300,
                  child: pickedImage != null
                      ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
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
            SizedBox(height: 10),
            Text(
              "Add Image",
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('save',style: TextStyle(fontSize: 18),),
              onPressed: () async {
                if (await performAddImages()) {
                  Navigator.pop(context);
                } else {
                  showSnackBar(
                      context: context,
                      content: 'error in add Images',
                      error: true);
                }
              },),
          ],
        ),
      ),
    );

  }
  Future<bool> performAddImages() async {
    if (checkData()) {
   //   await FbFirestoreController().CreateSlider(sliders: sliders, collectionName: 'Slider');

      return true;
    }
    return false;
  }
Carts get sliders{
    Carts sliders= Carts();
    sliders.imageProduct = url;
return sliders;


}
  bool checkData() {

      if (pickedImage != null) {
        showSnackBar(context: context, content: 'select pick image true');
        return true;
      }
      showSnackBar(
          context: context, content: 'please select an image', error: true);
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
    pickedImage = await imagePicker.pickImage(source: ImageSource.camera,imageQuality: 25);
    if (pickedImage != null) {
      setState(() {});
      uploadImage();
    }
  }

  Future<void> pickImageGallery() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 25);
    if (pickedImage != null) {
      // showSnackBar(context: context, content: 'imagetrue');
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

    // Within your widgets:
    // Image.network(downloadURL);
  }
}
