
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{
  static Future<Null> store(String userToken) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', userToken);
  }

  static Future<bool> read() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken') == null ? false : true;
  }

  static Future<Null> clear() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userToken');
  }
}