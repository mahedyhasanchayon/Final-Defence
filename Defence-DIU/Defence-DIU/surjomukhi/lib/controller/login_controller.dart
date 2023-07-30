import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:surjomukhi/model/login.dart';
import 'package:http/http.dart' as http;
import 'package:surjomukhi/utils/globalFunctions.dart';
import '../config/config.dart';

class LoginController {
  static GlobalFunction globals = GlobalFunction();
  //// Login Url
  Future<List<LoginData>> getSemesterResult(
      String studentID, String studentPass) async {
    userStudentId = studentID;
    userStudentPass = studentPass;
    List<LoginData> loginInfoObjList = [];
    Map data = {
      "grecaptcha": "",
      "password": studentPass,
      "username": studentID,
    };
    http.Response response = await http.post(
      Uri.parse("$baseUrl$studentLoginUrl"),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json", "Accept": "*/*"},
    );
    if (response.statusCode == 200) {
      var handle = await SharedPreferences.getInstance();
      //  handle.setString(key, value)
      Map student_Login_info = jsonDecode(response.body);
      loginResponseMessage = student_Login_info["message"];
      userStudentName = student_Login_info["name"];
      UserAccessToken = student_Login_info["accessToken"];
      List loginInfoList = [];
      loginInfoList.add(student_Login_info["accessToken"]);
      loginInfoList.add(student_Login_info["userName"]);
      loginInfoList.add(student_Login_info["name"]);

      for (int i = 0; i < loginInfoList.length; i++) {
        LoginData loginObj = LoginData(
            accessToken: loginInfoList[0],
            userId: loginInfoList[1]!,
            userName: loginInfoList[2]);
        loginInfoObjList.add(loginObj);
      }

      await handle.setString('UserAccessToken', UserAccessToken);
      await handle.setString('UserStudentPass', userStudentPass);
      await handle.setString('userStudentId', userStudentId);
      await handle.setString('currentUserId', userStudentId);
      await handle.setString('userStudentName', userStudentName);
      return loginInfoObjList;
    }
    return [];
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  /// Check Login Credentials
  Future<bool> isLogedIn(String reqPrefKey) async {
    String res = await globals.getPreferenceKey(reqPrefKey);
    return res.isNotEmpty ? true : false;
  }
}
