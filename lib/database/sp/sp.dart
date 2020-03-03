import 'package:shared_preferences/shared_preferences.dart';

class SP {
  static const String _SP_USER_NAME = "userName";

  static Future<SharedPreferences> _getSP() async {
    return await SharedPreferences.getInstance();
  }

  // sp添加登录状态（userName）
  static void addLoginStatus(String userName) async {
    final SharedPreferences sp = await _getSP();
    await sp.setString(_SP_USER_NAME, userName);
  }

  // 获取sp中存贮的登录状态
  static Future<String> getLoginStatus() async {
    final SharedPreferences sp = await _getSP();
    return sp.getString(_SP_USER_NAME) ?? '';
  }

  // 清除sp中登录状态
  static void removeLoginStatus() async {
    final SharedPreferences sp = await _getSP();
    await sp.remove(_SP_USER_NAME);
  }
}
