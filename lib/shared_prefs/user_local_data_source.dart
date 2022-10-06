import 'package:shared_preferences/shared_preferences.dart';

const String userIdPrefs = "USERID";

class UserLocalDataSource {
 

  static setUserId(String userId)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(userIdPrefs, userId);
  }

  static Future<String> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(userIdPrefs) ?? "";
  }

   static setCompanyId(String userId)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(userIdPrefs, userId);
  }

}