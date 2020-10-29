import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int _value = 0;

  get value => _value;

  void increment() {
    _value++;

    notifyListeners();
  }
}
