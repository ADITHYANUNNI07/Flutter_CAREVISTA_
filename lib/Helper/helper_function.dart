import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userPhoneKey = "USERPHONEKEY";
  static String userUIDKey = "USERUIDKEY";
  static String adkey = "ADMINKEY";
  static String imageURL = "USERIMAGEKEY";
//Saving the data to SF
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserUIDFromSF(String userID) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userUIDKey, userID);
  }

  static Future<bool> saveUserAdkeyFromSF(String admin) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(adkey, admin);
  }

  static Future<bool> saveUserImageURLSF(String imageurl) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(imageURL, imageurl);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool> saveUserPhoneSF(String isUserPhoneIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userPhoneKey, isUserPhoneIn);
  }

//Getting the data from SF
  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future<String?> getUserUIDFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userUIDKey);
  }

  static Future<String?> getUserPhoneFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userPhoneKey);
  }

  static Future<String?> getUserAdkeyFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(adkey);
  }

  static Future<String?> getUserImageURLFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(imageURL);
  }
}
