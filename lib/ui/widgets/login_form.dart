/// 登录页面
/// create by monkeycf on 2020/02/25
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
import '../../module/login.dart';
import 'password_field.dart';
import 'submit_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final Login _login = Login();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  void showInSnackBar(String value) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  void _resetDisabled() {
    setState(() {
      _login.resetWrongCount();
    });
  }

  /// 锁定提示
  Future<void> _lockHints() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('账号密码错误'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('请在60s后再次尝试'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('好的'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// 提交失败的错误处理
  void _submitErrorHandler() {
    if (_login.addWrong()) {
      showInSnackBar("账号或密码错误，您还可输入${_login.residueCount()}次");
    } else {
      setState(() {
        _login.addWrong(); // 主动增加错误次数，修改wrongCount
      });
      Scaffold.of(context).hideCurrentSnackBar();
      _lockHints();
    }
  }

  /// 提交成功处理
  void _submitSuccessHandler() async {
    final String userName = _login.userName;

    // 保存登录状态
    Login.addLoginStatus(userName);

    Timer(Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/homepage',
        (route) => route == null,
        arguments: {"userName": userName},
      );
    });
    showInSnackBar("登录成功");
  }

  /// 提交表单
  void _handleSubmitted({registerStatus: false}) {
    final form = _formKey.currentState;
    // 表单校验
    if (!form.validate()) {
      _autoValidate = true;
      showInSnackBar("登录前请先修复红色提示错误!");
    } else if (_login.protocolFlag != true) {
      // 用户协议判断
      showInSnackBar("请同意用户协议");
    } else {
      form.save();
      if (registerStatus == false) {
        // 登录 false，注册 true
        if (_login.submit()) {
          _submitSuccessHandler();
        } else {
          _submitErrorHandler();
        }
      }
    }
  }

  /// 校验账号
  String _validateName(String value) {
    if (value.isEmpty) {
      return "账号不能为空";
    }
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return "账号只能是英文字母";
    }
    return null;
  }

  /// 校验密码
  String _validatePassword(String password) {
    if (password.isEmpty) {
      return "密码不能为空";
    }
    final passwordExp = RegExp(r'^\w+$');
    if (!passwordExp.hasMatch(password)) {
      return "密码只能为英文字母及数字";
    }
    return null;
  }

  /// 阅读用户协议
  void _readUserAgreement() async {
    var flag = await Navigator.pushNamed(context, '/user/agreement');
    if (flag == true) {
      setState(() {
        _login.protocolFlag = true;
      });
    } else {
      setState(() {
        _login.protocolFlag = false;
      });
      showInSnackBar("请同意协议");
    }
  }

  @override
  Widget build(BuildContext context) {
    final cursorColor = Theme.of(context).cursorColor;
    const sizedBoxSpace = SizedBox(height: 24);

    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 96),
                TextFormField(
                    cursorColor: cursorColor,
                    decoration: InputDecoration(
                      filled: true,
                      icon: Icon(Icons.person),
                      hintText: "your account",
                      labelText: "请输入登录账号*",
                    ),
                    validator: _validateName,
                    onSaved: (value) {
                      _login.userName = value;
                    }),
                sizedBoxSpace,
                PasswordField(
                    helperText: "密码长度不超过8位",
                    labelText: "请输入登录密码*",
                    validator: _validatePassword,
                    onSaved: (value) {
                      _login.password = value;
                    }),
                sizedBoxSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                        _login.protocolFlag ? Icons.check : Icons.error_outline,
                        color: Colors.grey),
                    SizedBox(width: 8),
                    Text.rich(TextSpan(
                      text: '同意用户协议',
                      style: TextStyle(color: Colors.cyan),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _readUserAgreement,
                    )),
                  ],
                ),
                Center(child: Text("账号：monkeycf，密码：123456")),
                Expanded(
                  child: Center(
                    child: SubmitButton(
                      child: Text("登录"),
                      onPressed: _handleSubmitted,
                      disabledType: _login.getDisableType(),
                      changeDisabled: _resetDisabled,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
