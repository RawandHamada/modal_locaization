import 'package:flutter/material.dart';
import 'package:modal/auth/login_admin_screen.dart';
import 'package:modal/product/add_products_screen.dart';
import 'package:modal/bn_screen/home_screen.dart';
import 'package:modal/bn_screen/profile_screen.dart';
import 'package:modal/category/categories_screen.dart';
import 'package:modal/models/bn_screen.dart';
import 'package:modal/settings_screen.dart';
import 'product/products_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex=0;


  @override
  Widget build(BuildContext context) {
    List<BnScreen> _bnScreens=<BnScreen>[
      BnScreen(title: AppLocalizations.of(context)!.home, widget: HomeScreen()),
      BnScreen(title: AppLocalizations.of(context)!.categories, widget: CategoriesScreen()),
      BnScreen(title: AppLocalizations.of(context)!.admin, widget: LoginAdminScreen()),
      BnScreen(title: AppLocalizations.of(context)!.product, widget: ProductsScreen()),
      BnScreen(title: AppLocalizations.of(context)!.settings, widget: SettingsScreen()),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xBF107AAA),
        title: Text(_bnScreens[_currentIndex].title),
        iconTheme: IconThemeData(color: Colors.black),
       /* actions: [
          *//*Visibility(
              visible:_currentIndex==1  ,
              child:
              IconButton(onPressed: () => Navigator.pushNamed(context,'/add_category_screen'),
                icon: Icon(Icons.add),)),
          Visibility(
              visible:_currentIndex==3  ,
              child:
              IconButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProductsScreen()));
              },
                icon: Icon(Icons.add),)),*//*
      *//*Visibility(
        visible:_currentIndex==0  ,
        child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            icon: Icon(Icons.settings),
          ),
      )
        ],*/
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('images/logo.png')
                  ),
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: AlignmentDirectional.topStart,
                          end: AlignmentDirectional.bottomEnd,
                          colors: [
                        Colors.blue.shade300, Color(0xBF107AAA),
                      ])),
                  accountName: Text(AppLocalizations.of(context)!.johnDeo,style:TextStyle(fontSize: 18),),
                  accountEmail: Text(AppLocalizations.of(context)!.johndeoyourmail,style:TextStyle(fontSize: 15),),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(AppLocalizations.of(context)!.shop),
              trailing: Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart_screen');
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today_sharp),
              title: Text(AppLocalizations.of(context)!.events),
              trailing: Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart_screen');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(AppLocalizations.of(context)!.about),
              trailing: Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () => Navigator.pushNamed(context, '/cart_screen'),
            ),
            Divider(
              indent: 0,
              endIndent: 50,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            ListTile(
              leading: Icon(Icons.indeterminate_check_box),
              title: Text(AppLocalizations.of(context)!.termsconditions),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login_screen');
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text(AppLocalizations.of(context)!.privacypolicy),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login_screen');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(AppLocalizations.of(context)!.logout),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login_screen');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(

        onTap: (int selectedItemIndex) {
          setState(() {
            _currentIndex = selectedItemIndex;
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        //type: BottomNavigationBarType.shifting,
        showSelectedLabels: true,
        selectedItemColor: Colors.red,
        selectedIconTheme: IconThemeData(color: Colors.redAccent),
        unselectedItemColor: Colors.grey.shade500,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        iconSize: 23,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w200),
        backgroundColor: Colors.white,
        elevation: 10,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: AppLocalizations.of(context)!.categories,
          ),
          BottomNavigationBarItem(
            label: '',
            icon: FloatingActionButton(
          backgroundColor:Color(0xBF107AAA),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginAdminScreen()),
                );
              },
              child: Icon(Icons.add,),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: AppLocalizations.of(context)!.product,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
      body: _bnScreens[_currentIndex].widget,
    );
  }
}
