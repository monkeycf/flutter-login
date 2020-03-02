/// 登录
/// created by monkeycf on 2020/02/24
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  static const int _MAX_WRONG_COUNT = 3;
  static const String _SP_USER_NAME = "userName";
  int _wrongCount = 0;
  String userName;
  String _password;
  bool protocolFlag = false;

  void resetWrongCount() {
    _wrongCount = 0;
  }

  bool addWrong() {
    return ++_wrongCount < _MAX_WRONG_COUNT;
  }

  bool getDisableType() {
    return residueCount() < 0;
  }

  int residueCount() {
    return _MAX_WRONG_COUNT - _wrongCount;
  }

  bool submit() {
    return validateUser(userName, _password);
  }

  set password(String value) {
    _password = value;
  }

  // sp添加登录状态（userName）
static  void addLoginStatus(String userName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString("userName", userName);
  }

  // 获取sp中存贮的登录状态
  static Future<String> getLoginStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(_SP_USER_NAME) ?? '';
  }

  // 清除sp中登录状态
 static void removeLoginStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(_SP_USER_NAME);
  }
}
