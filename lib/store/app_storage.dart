import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage with ChangeNotifier {
  final SharedPreferences _prefs;

  late String _closeDate;
  bool _isLogin = false;
  late String _password;

  static const closeDateKey = 'closeDate';
  static const isLoginKey = 'isLogin';
  static const passwordKey = 'passwordKey';

  AppStorage(this._prefs) {
    _closeDate = _prefs.getString(closeDateKey) ?? DateTime.now().toString();
    _isLogin = _prefs.getBool(isLoginKey) ?? false;
    _password = _prefs.getString(passwordKey) ?? '123456';
  }

  static Future<AppStorage> create() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return AppStorage(sharedPreferences);
  }

  String get closeDate => _closeDate;

  set closeDate(String val) {
    _closeDate = val;
    _prefs.setString(closeDateKey, val);
    notifyListeners();
  }

  bool get isLogin => _isLogin;

  set isLogin(bool val) {
    _isLogin = val;
    _prefs.setBool(isLoginKey, val);
    notifyListeners();
  }

  String get password => _password;

  set password(String val) {
    _password = val;
    _prefs.setString(passwordKey, val);
    notifyListeners();
  }
}
