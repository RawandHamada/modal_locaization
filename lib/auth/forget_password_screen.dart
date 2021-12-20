
import 'package:flutter/material.dart';
import 'package:modal/firebase/fb_auth_controller.dart';
import 'package:modal/responsive/size_config.dart';
import 'package:modal/utils/helpers.dart';
import 'package:modal/widgets/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with Helpers {
  late TextEditingController _emailTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.72).designHeight(8.12).init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        iconTheme: IconThemeData(
            color: Colors.white
        ),
        elevation: 1,
        backgroundColor: Color(0xBF107AAA),
        title: Text(
          AppLocalizations.of(context)!.fORGETPASSWORD,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
      ),
      body: ListView(
        children:[
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.fORGETPASSWORD,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.enteremailtoreceiveresetlink,

                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              AppTextField(
                hint:AppLocalizations.of(context)!.email,
                controller: _emailTextController,
                maxLength: 30,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:Color(0xBF107AAA),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await performForgetPassword();
                },
                child: Text(AppLocalizations.of(context)!.send),
              ),
            ],
          ),
        ),
     ] ),
    );
  }

  Future<void> performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, content: 'Enter required data!');
    return false;
  }

  Future<void> forgetPassword() async {
    bool status = await FbAuthController().forgetPassword(context, email: _emailTextController.text);
    if(status){
      showSnackBar(context: context, content: 'Reset email sent successfully, check and confirm');
      Navigator.pop(context);
    }
  }
}
