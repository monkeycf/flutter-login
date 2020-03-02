/// 路由匹配
/// created by monkeycf on 2020/02/25

import 'package:flutter/material.dart';
import '../views/homepage.dart';
import '../views/login.dart';
import '../views/user_agreement.dart';

const String BUILDER = "builder";

// 路由map
final Map router = {
  '/': {BUILDER: (context, {arguments}) => LoginView()},
  '/user/agreement': {BUILDER: (context, {arguments}) => UserAgreementView()},
  '/homepage': {BUILDER: (context, {arguments}) => Homepage(arguments)}
};

final RouteFactory onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Object argument = settings.arguments;
  final _widgetBuilder = router[name];

  assert(_widgetBuilder != null);
  // 根据是否传参，区分调用
  return argument == null
      ? MaterialPageRoute(
          builder: (context) => _widgetBuilder[BUILDER](context),
        )
      : MaterialPageRoute(
          builder: (context) =>
              _widgetBuilder[BUILDER](context, arguments: argument),
        );
};
