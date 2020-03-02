/// 首页
/// created by monkeycf on 2020/02/25
import 'package:flutter/material.dart';
import 'package:login_dome/module/login.dart';

class Homepage extends StatelessWidget {
  final Map arguments;

  Homepage(this.arguments);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("首页")),
      body: Center(
        child: Text('''用户名：${this.arguments["userName"] ?? "用户名"}'''),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('注销'),
        onPressed: () {
          // 清除登录状态，重定向登录页面
          Login.removeLoginStatus();
          Navigator.pushNamedAndRemoveUntil(
              context, '/', (route) => route == null);
        },
      ),
    );
  }
}
