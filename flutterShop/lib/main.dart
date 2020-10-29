import 'package:flutter/material.dart';
import 'route.dart';
import 'package:provider/provider.dart';
import './provide/counter.dart';
import './provide/child_category.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Counter()),
      ChangeNotifierProvider(create: (context) => ChildCategory())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.pink),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    ),
  ));
}
