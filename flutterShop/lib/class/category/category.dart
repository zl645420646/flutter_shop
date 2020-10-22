import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterShop/service/service_method.dart';
import '../../model/category.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('分类')),
      body: Text('data'),
    );
  }

  //获取数据
  void _getCategoryList() async {
    await request('getCategory').then((value) {
      var data = json.decode(value.toString());
      CategoryModel list = CategoryModel.fromJson(data);
      list.data.forEach((element) {
        print(element.mallCategoryName);
      });
      // print(value);
    });
  }
}
