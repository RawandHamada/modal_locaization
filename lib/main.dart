import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:modal/auth/login_admin_screen.dart';
import 'package:modal/cart_screen.dart';
import 'package:modal/category/admin_categories_screen.dart';
import 'package:modal/control_panel_admin/added_image_screen.dart';
import 'package:modal/control_panel_admin/control_screen.dart';
import 'package:modal/auth/create_account_screen.dart';
import 'package:modal/auth/forget_password_screen.dart';
import 'package:modal/auth/login_screen.dart';
import 'package:modal/bn_screen/home_screen.dart';
import 'package:modal/bn_screen/profile_screen.dart';
import 'package:modal/category/add_admin_category_screen.dart';
import 'package:modal/category/categories_screen.dart';
import 'package:modal/launch_screen.dart';
import 'package:modal/main_screen.dart';
import 'package:modal/models/products.dart';
import 'package:modal/preferences/app_preferences.dart';
import 'package:modal/product/add_products_screen.dart';
import 'package:modal/product/admin_product_screen.dart';
import 'package:modal/product/product_detail_screen.dart';
import 'package:modal/product/products_screen.dart';
import 'package:modal/reports_screen.dart';
import 'package:modal/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'add_modal_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppPreferences().initPreferences();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  static changeLanguage(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    if (state != null) state.changeLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale(AppPreferences().language);


  void changeLocale(Locale locale) {
    AppPreferences().setLanguage(locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar'),
        Locale('en'),
      ],
      locale: _locale,
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/main_screen': (context) => MainScreen(),
        '/settings_screen': (context) => SettingsScreen(),
        '/profile_screen': (context) => ProfileScreen(),
         '/home_screen': (context) => HomeScreen(),
         '/products_screen': (context) => ProductsScreen(),
         '/categories_screen': (context) => CategoriesScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/login_admin_screen': (context) => LoginAdminScreen(),
        '/forget_password_screen': (context) => ForgetPasswordScreen(),
        '/create_account_screen': (context) => CreateAccountScreen(),
     //   '/add_category_screen': (context) => AddCategoryScreen(),
        '/admin_product_screen': (context) => AdminProductScreen(),
        '/add_modalist_screen': (context) => AddModalScreen(),
        '/reports_screen': (context) => ReportsScreen(),
        '/control_screen': (context) => ControlScreen(),
        '/added_image_screen': (context) => AddedImageScreen(),
        '/admin_category_screen': (context) => AdminCategoriesScreen(),

      },
    );
  }
}



