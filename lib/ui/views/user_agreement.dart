/// 用户协议
/// created by monkeycf on 2020/02/25

import 'package:flutter/material.dart';

class UserAgreementView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('用户协议')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('用户协议用户协议用户协议用户协议用户协议用户协议用户协议用户协议用户协议'),
        ),
      ),
      bottomSheet: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              height: 48,
              child: Text('拒绝', style: TextStyle(color: Colors.white)),
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ),
          Expanded(
            child: MaterialButton(
              height: 48,
              child: Text("接受", style: TextStyle(color: Colors.white)),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ),
        ],
      ),
    );
  }
}
