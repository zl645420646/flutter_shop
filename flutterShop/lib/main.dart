import 'package:flutter/material.dart';
import 'package:flutterShop/provide/cart_provide.dart';
import 'route.dart';
import 'package:provider/provider.dart';
import './provide/child_category.dart';
import 'provide/goodsDetailsProvide.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ChildCategory()),
      ChangeNotifierProvider(create: (context) => GoodsDetailsProvide()),
      ChangeNotifierProvider(create: (context) => CartProvide())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.pink),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    ),
  ));
}
