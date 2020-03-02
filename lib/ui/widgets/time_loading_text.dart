/// 倒计时文本
/// created by monkeycf on 2020/02/25

import 'dart:async';
import 'package:flutter/material.dart';

class TimeLoadingText extends StatefulWidget {
  final Function changeStatus;

  TimeLoadingText(this.changeStatus);

  @override
  _TimeLoadingTextState createState() => _TimeLoadingTextState();
}

class _TimeLoadingTextState extends State<TimeLoadingText> {
  int timeRemaining = 60;
  static const timeOut = const Duration(seconds: 1);

  _TimeLoadingTextState() {
    Timer.periodic(timeOut, (timer) {
      setState(() {
        --timeRemaining;
      });
      if (timeRemaining <= 0) {
        widget.changeStatus();
        timer.cancel();
        timer = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("${timeRemaining}s");
  }
}
