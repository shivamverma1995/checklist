import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _sharedPreferences;
  static Future<SharedPreferences> get _instance async =>
      _sharedPreferences ?? await SharedPreferences.getInstance();

  ///initialize sharedPreferences instance
  static Future<SharedPreferences?> init() async {
    _sharedPreferences = await _instance;
    return _sharedPreferences;
  }

  //Item Name
  static void setItemName(String text) =>
      _sharedPreferences!.setString("text", text);

  static String getItemName() => _sharedPreferences!.getString("text") ?? "";
}
