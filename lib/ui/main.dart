import 'package:flutter/material.dart';
import './route/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
