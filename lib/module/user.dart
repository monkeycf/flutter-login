/// 用户
/// created by monkeycf on 2020/02/24

class User {
  final String _userAccount;
  final String _userPassword;

  User(this._userAccount, this._userPassword);

  String get userAccount => _userAccount;

  bool _validatePassWord(String password) => password == _userPassword;
}

final users = [User("monkeycf", "123456")];

/// 验证用户
bool validateUser(String userName, String password) {
  return users.any((item) =>
      item.userAccount == userName && item._validatePassWord(password));
}
