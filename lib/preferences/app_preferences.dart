import 'package:modal/models/category.dart';
import 'package:modal/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();
  late SharedPreferences _sharedPreferences;

  factory AppPreferences() {
    return _instance;
  }

  AppPreferences._internal();

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required Users user}) async {
    await _sharedPreferences.setBool('logged_in', true);
    await _sharedPreferences.setString('email', user.email);
    await _sharedPreferences.setString('name', user.name);
  }

  Users get user {
    return Users(
      name: _sharedPreferences.getString('name') ?? '',
      email: _sharedPreferences.getString('email') ?? '',
      password: _sharedPreferences.getString('password') ??'',
      uid: _sharedPreferences.getString('uid') ??'',
    );
  }
  String get language => _sharedPreferences.getString('language') ?? 'en';

  Future<void> setLanguage(String newLanguageCode) async {
    await _sharedPreferences.setString('language', newLanguageCode);
  }
  bool get loggedIn => _sharedPreferences.getBool('logged_in') ?? false;

  Future<bool> logout() async {
    // return await _sharedPreferences.remove('key');
    return await _sharedPreferences.clear();
  }
  Future<void> saveCategory({required Category category}) async {
    await _sharedPreferences.setString('titleCategory', category.title);
  }
  Category getCategory(){
    Category category = Category();
    category.title =_sharedPreferences.getString('titleCategory')!;
    return category;
  }
  Future<bool> clearCategory() async {
    // return await _sharedPreferences.remove('key');
    return await _sharedPreferences.remove('titleCategory');
  }





}
