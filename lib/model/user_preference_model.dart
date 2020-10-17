import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferenceModel extends ChangeNotifier {
  bool _userAccuracyMode = false;

  void setAccuracyMode() async {
    SharedPreferencesHelper.setAccuracyMode(!_userAccuracyMode);
    _userAccuracyMode = await SharedPreferencesHelper.getAccuracyMode();
    notifyListeners();
  }

  bool get getAccuracyMode => _userAccuracyMode;
}

class SharedPreferencesHelper {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _kAccuracyMode = "accuracy";

  /// ------------------------------------------------------------
  /// Method that returns the user accuracy code, 'false' if not set
  /// ------------------------------------------------------------
  static Future<bool> getAccuracyMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kAccuracyMode) ?? false;
  }

  /// ----------------------------------------------------------
  /// Method that saves the user accuracy code
  /// ----------------------------------------------------------
  static Future<bool> setAccuracyMode(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kAccuracyMode, value);
  }
}
