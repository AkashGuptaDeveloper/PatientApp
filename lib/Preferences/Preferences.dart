import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // ignore: non_constant_identifier_names
  static var KEY_USER_status = "status";
  // ignore: non_constant_identifier_names
  static var KEY_USER_login = "login";
  static var KEY_USER_signup = "signup";
  static var KEY_USER_token = "user_token";
  static var KEY_USER_msg = "msg";

  storeDataAtLogin(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_USER_status, data["status"].toString());
    prefs.setString(KEY_USER_login, data["login"].toString());
    prefs.setString(KEY_USER_signup, data["signup"].toString());
    prefs.setString(KEY_USER_token, data["user_token"].toString());
    prefs.setString(KEY_USER_msg, data["msg"].toString());

    /*print("KEY_USER_status" + data["status"].toString());
    print("KEY_USER_login" + data["login"].toString());
    print("KEY_USER_signup" + data["signup"].toString());
    print("KEY_USER_user_token" + data["user_token"].toString());
    print("KEY_USER_msg" + data["msg"].toString());*/
  }
}
