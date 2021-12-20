import 'package:flutter/material.dart';
import 'package:modal/preferences/app_preferences.dart';
import 'package:modal/responsive/size_config.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      String route = AppPreferences().loggedIn ? '/main_screen' : '/login_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.72).designHeight(8.12).init(context);

    return Scaffold(
        backgroundColor:  Color(0xBF107AAA),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120.0,
              width: 130.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'images/logo.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            SizedBox(height: 5),
            Text('شركة مودال',style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              fontSize: 24,),
          ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 60),
              child: Text('للألمنيوم والاستثمار',style: TextStyle(color: Color(0XFFFFDED8AD),
                fontWeight: FontWeight.normal,
                fontFamily: 'Cairo',
                fontSize: 18,),
          ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(right:50),
              child: Text('اسم يستحق الثقة',style: TextStyle(color: Color(0XFFFFDED8AD),
                fontWeight: FontWeight.normal,
                fontFamily: 'Cairo',

                fontSize: 18,),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: Text('وعهد الالمنيوم الجديد',style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: 'Cairo',

                fontSize: 16,),
      ),
            ),
          ],
        ),
      )
    );
  }
}
