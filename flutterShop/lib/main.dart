import 'package:flutter/material.dart';
import 'route.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.pink),
    initialRoute: '/',
    onGenerateRoute: onGenerateRoute,
  ));
}
