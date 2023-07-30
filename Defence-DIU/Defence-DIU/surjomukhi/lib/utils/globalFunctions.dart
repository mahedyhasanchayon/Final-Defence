import 'package:shared_preferences/shared_preferences.dart';

class GlobalFunction {
////  Get Value ...
  Future<String> getPreferenceKey(String reqPrefKey) async {
    SharedPreferences _globalPref = await SharedPreferences.getInstance();
    return _globalPref.getString(reqPrefKey) ?? 'null';
  }

//// Set Value ...
  Future<bool> setPreferenceKey(String reqPrefKey, String reqVal) async {
    SharedPreferences _globalPref = await SharedPreferences.getInstance();
    return _globalPref.setString(reqPrefKey, reqVal);
  }
}
