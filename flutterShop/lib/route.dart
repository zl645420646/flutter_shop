import 'package:flutter/material.dart';

import 'tabs.dart';
import 'class/home/home.dart';
import 'class/category/category.dart';
import 'class/cart/cart.dart';
import 'class/mine/mine.dart';

final routes = {'/': (context) => TabBarPage()};

// 生成路由回调的的固定写法
// ignore: missing_return
var onGenerateRoute = (RouteSettings settings) {
  //统一处理：
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
