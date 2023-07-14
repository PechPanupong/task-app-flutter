import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage with ChangeNotifier {
  final SharedPreferences _prefs;
  final Map<String, dynamic> _localStore = {};

  dynamic _closeDate;
  bool? _isLogin;

  static const closeDateKey = 'closeDate';
  static const isLoginKey = 'isLogin';

  // private constructor
  AppStorage._create(this._prefs) {
    _closeDate = _prefs.getString(closeDateKey);
    _isLogin = _prefs.getBool(isLoginKey);
  }

  // factory to to inject async dependenies
  static Future<AppStorage> create() async {
    return AppStorage._create(await SharedPreferences.getInstance());
  }

  dynamic get closeDate {
    return _closeDate;
  }

  set closeDate(dynamic val) {
    _closeDate = val.toString();
    _prefs.setString(closeDateKey, val.toString());
    notifyListeners();
  }

  bool get isLogin {
    return _isLogin ?? false;
  }

  set isLogin(bool val) {
    _isLogin = val;
    _prefs.setBool(isLoginKey, val);
  }
}
