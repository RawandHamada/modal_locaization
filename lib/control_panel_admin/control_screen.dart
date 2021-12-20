import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xBF107AAA),
        title: Text(AppLocalizations.of(context)!.controlpanel),),
      body: SizedBox(
        height: 500,
        child: GridView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 160 / 170),
          children: [
            buildElevatedButton(context,route:'/admin_category_screen',iconImage: 'images/box.png',label: AppLocalizations.of(context)!.categories),
            buildElevatedButton(context,route:'/admin_product_screen',iconImage: 'images/package.png',label: AppLocalizations.of(context)!.product),
          ],
        ),
      )
    );

  }

    ElevatedButton buildElevatedButton(BuildContext context, {required String route,required String iconImage, required String label}) {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconImage),
            SizedBox(width: 8,),
            Text(label,style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),)
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: Color(0xFFFFFFFF),
            elevation: 1
        ),
      );
    }}


