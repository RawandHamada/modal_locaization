
import 'package:flutter/material.dart';
import 'package:modal/firebase/fb_auth_controller.dart';
import 'package:modal/responsive/size_config.dart';
import 'package:modal/utils/helpers.dart';
import 'package:modal/widgets/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.72).designHeight(8.12).init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: Color(0xBF107AAA)
    ),
      elevation: 1,
        backgroundColor: Color(0xBF107AAA),
        title: Text(
          AppLocalizations.of(context)!.createnewaccount,
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
              AppLocalizations.of(context)!.createnewaccount,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 5),
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
                await performCreateAccount();
              },
              child: Text(AppLocalizations.of(context)!.createnewaccount),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.of(context)!.alreadyhaveanaccount,style: TextStyle(color: Color(0xBF107AAA))),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    indent: 8,
                    endIndent: 8,
                    color: Colors.grey.shade500,
                    width: 1,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login_screen'),
                    child: Text(AppLocalizations.of(context)!.signin,style: TextStyle(color: Color(0xBF107AAA))),
                  ),
                ],
              ),
            )
          ],
        ),
      
    );
  }

  Future<void> performCreateAccount() async {
    if (checkData()) {
      await createAccount();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, content: AppLocalizations.of(context)!.enteremailandpassword);
    return false;
  }

  Future<void> createAccount() async {
    bool status = await FbAuthController().createAccount(context,
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (status) Navigator.pop(context);
  }
}
