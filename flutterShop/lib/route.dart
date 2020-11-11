import 'package:flutter/material.dart';
import 'tabs.dart';
import './class/category/details_page.dart';

final routes = {
  '/': (context) => TabBarPage(),
  '/detail': (context) => DetailsPage(),
};

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
