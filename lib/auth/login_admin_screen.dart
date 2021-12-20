
import 'package:flutter/material.dart';
import 'package:modal/firebase/fb_auth_controller.dart';
import 'package:modal/models/user.dart';
import 'package:modal/preferences/app_preferences.dart';
import 'package:modal/responsive/size_config.dart';
import 'package:modal/utils/helpers.dart';
import 'package:modal/widgets/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({Key? key}) : super(key: key);

  @override
  _LoginAdminScreenState createState() => _LoginAdminScreenState();
}

class _LoginAdminScreenState extends State<LoginAdminScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('3');
  }

  @override
  void didUpdateWidget(covariant LoginAdminScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print(4);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.72).designHeight(8.12).init(context);
    print('build');
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color(0xBF107AAA),
        title: Text(
          AppLocalizations.of(context)!.signInAdmin,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 100),
          children: [
            Text(
              AppLocalizations.of(context)!.logintocontinueyouraccount,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.enteremailandpassword,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            AppTextField(
              hint: AppLocalizations.of(context)!.email,
              controller: _emailTextController,
              maxLength: 30,

            ),
            SizedBox(height: 10),
            AppTextField(
              hint: AppLocalizations.of(context)!.password,
              controller: _passwordTextController,
              obscureText: true,
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
                await performSignIn();
              },
              child: Text( AppLocalizations.of(context)!.signin),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/create_account_screen'),
                    child: Text(AppLocalizations.of(context)!.signup,style: TextStyle(color: Color(0xBF107AAA)),),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    indent: 8,
                    endIndent: 8,
                    color: Colors.grey.shade500,
                    width: 1,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/forget_password_screen'),
                    child: Text(AppLocalizations.of(context)!.fORGETPASSWORD,style: TextStyle(color: Color(0xBF107AAA))),
                  ),
                ],
              ),
            )
          ],
        ),

    );
  }

  Future<void> performSignIn() async {
    if (checkData()) {
      await signIn();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, content: 'Enter required data!');
    return false;
  }

  Future<void> signIn() async {
    await AppPreferences().save(user: user);
    bool status = await FbAuthController().signInAdmin(context,
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (status) {
      Future.delayed(Duration(seconds: 2),(){
        Navigator.pushReplacementNamed(context,'/control_screen');
      });
    }
  }
  Users get user {
    return Users(
      email: _emailTextController.text,
      name: 'User Name',
       uid: '', password: _passwordTextController.text
    );
  }
}
