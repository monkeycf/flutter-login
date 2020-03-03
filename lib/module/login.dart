/// 登录
/// created by monkeycf on 2020/02/24
import 'user.dart';

class Login {
  static const int _MAX_WRONG_COUNT = 3;
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
}
