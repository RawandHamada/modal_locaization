
import 'package:flutter/material.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/models/modalist.dart';
import 'package:modal/utils/helpers.dart';
import 'package:modal/widgets/app_text_field.dart';

class AddModalScreen extends StatefulWidget {
  final Modalist? modalist;

  AddModalScreen({this.modalist});

  @override
  _AddModalScreenState createState() => _AddModalScreenState();
}

class _AddModalScreenState extends State<AddModalScreen> with Helpers {


  @override late TextEditingController _titleTextController;
  late TextEditingController _contentTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextController =
        TextEditingController(text: widget.modalist?.title ?? '');
    _contentTextController =
        TextEditingController(text: widget.modalist?.content ?? '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleTextController.dispose();
    _contentTextController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.modalist != null ? 'UPDATE modalist' : 'ADD modalist',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          AppTextField(
            hint: 'Title',
            controller: _titleTextController,
          ),
          SizedBox(height: 15),
          AppTextField(
            hint: 'Content',
            controller: _contentTextController,
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async => await performSave(),
            child: Text('SAVE'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
          )
        ],
      ),
    );
  }

  Future<void> performSave() async {
    if (checkData()) {
      if (widget.modalist == null)
        await save();
      else
        await update();
    }
  }

  bool checkData() {
    if (_titleTextController.text.isNotEmpty &&
        _contentTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, content: 'Enter required data', error: true);
    return false;
  }

  Future<void> save() async {
    bool status = await FbFirestoreController().createlistModal(modalist: modalist);
    if (status) {
      showSnackBar(context: context, content: 'News saved successfully');
      clear();
    }
  }

  Future<void> update() async {
    bool status = await FbFirestoreController()
        .updatelistModal(path:  widget.modalist!.path, modalist: modalist);
    if (status) {
      showSnackBar(context: context, content: 'News saved successfully');
      Navigator.pop(context);
    }
  }

  Modalist get modalist {
    Modalist modalist = Modalist();
    modalist.title = _titleTextController.text;
    modalist.content = _contentTextController.text;
    return modalist;
  }

  void clear() {
    _titleTextController.text = '';
    _contentTextController.text = '';
  }
}
