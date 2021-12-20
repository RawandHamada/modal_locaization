import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal/firebase/fb_auth_controller.dart';
import 'package:modal/main.dart';
import 'package:modal/models/address.dart';
import 'package:modal/preferences/app_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;
  String _language = 'ar';

  @override
  Widget build(BuildContext context) {
    List<Address> _addresses = <Address>[
      Address(name: AppLocalizations.of(context)!.gaza, status: false),
      Address(name: AppLocalizations.of(context)!.rafah, status: false),
      Address(name: AppLocalizations.of(context)!.khanyounis, status: false),
    ];


    return ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          SwitchListTile(
            title: Text( AppLocalizations.of(context)!.notifications),
            subtitle: Text(AppLocalizations.of(context)!.enableDisableNotification),
            value: _notifications,
            onChanged: (bool value) {
              setState(() {
                _notifications = value;
              });
            },
          ),
          Divider(height: 20, color: Colors.grey.shade500),
          Text(
            AppLocalizations.of(context)!.address,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
            ),
          ),
          for (Address address in _addresses)
            CheckboxListTile(
              title: Text(address.name),
              value: address.status,
              onChanged: (bool? status) {
                if (status != null)
                  setState(() {
                    address.status = status;
                  });
              },
            ),
          Divider(height: 20, color: Colors.grey.shade500),
          ListTile(
            onTap: (){
              String newLanguage = AppPreferences().language == 'en' ? 'ar' : 'en';
           MyApp.changeLanguage(context, Locale(newLanguage));} ,
            leading: Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.language),
            subtitle: Text(AppLocalizations.of(context)!.selectappropriatelanguage),
          ),
          ListTile(
            onTap: (){signOut();} ,
            leading: Icon(Icons.logout),
            title: Text(AppLocalizations.of(context)!.logout),
            subtitle: Text(AppLocalizations.of(context)!.waitingyourreturn),
          ),
        ],

    );
  }

  void showLogoutDialog() {
    showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirm Logout'),
            content: Text('Are you sure!'),
            actionsOverflowDirection: VerticalDirection.up,
            actionsOverflowButtonSpacing: 30,
            // actionsPadding: EdgeInsets.only(right: 30),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.blue, width: 2),
            ),
            // insetPadding: EdgeInsets.only(left: 40),
            actions: [
              TextButton(
                  onPressed: () async{
                    await signOut();
                    Navigator.pop(context);
                  }, child: Text('yes'),),
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('NO')),
            ],
          );
        });
  }

  void showLanguageDialog() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      barrierColor: Colors.black.withOpacity(0.26),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: Text('English'),
                    value: 'en',
                    groupValue: _language,
                    onChanged: (String? value) {
                      if (value != null)
                        setState(() {
                          _language = value;
                        });

                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Arabic'),
                    value: 'ar',
                    groupValue: _language,
                    onChanged: (String? value) {
                      if (value != null)
                        setState(() {
                          _language = value;
                        });
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
  Future<void> signOut() async {
    await FbAuthController().signOut();
    Navigator.pushReplacementNamed(context, '/login_screen');
  }
}
