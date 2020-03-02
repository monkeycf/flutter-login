/// 提交按钮
/// created by monkeycf on 2020/02/24

import 'package:flutter/material.dart';
import 'time_loading_text.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final bool disabledType;
  final Function changeDisabled;

  SubmitButton({
    this.child,
    this.disabledType: false,
    @required this.onPressed,
    @required this.changeDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: this.disabledType
            ? TimeLoadingText(this.changeDisabled)
            : this.child,
        onPressed: this.disabledType ? null : this.onPressed);
  }
}
