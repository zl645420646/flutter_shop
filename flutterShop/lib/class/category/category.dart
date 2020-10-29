import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterShop/provide/child_category.dart';
import 'package:flutterShop/provide/counter.dart';
import 'package:flutterShop/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/category.dart';
import 'package:provider/provider.dart';

List categoryDataList = [];

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
      body: Row(
        children: [LeftCategoryNavState(), RightCategoryGoodsState()],
      ),
    );
  }

  //获取数据
  void _getCategoryList() async {
    await request('getCategory').then((value) {
      var data = json.decode(value.toString());
      CategoryModel list = CategoryModel.fromJson(data);
      setState(() {
        categoryDataList = list.data;
      });

      print(categoryDataList.length);
      // print(value);
    });
  }
}

//左边导航栏
class LeftCategoryNavState extends StatefulWidget {
  LeftCategoryNavState({Key key}) : super(key: key);

  @override
  _LeftCategoryNavStateState createState() => _LeftCategoryNavStateState();
}

class _LeftCategoryNavStateState extends State<LeftCategoryNavState> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(150),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
          itemCount: categoryDataList.length,
          itemBuilder: (context, index) {
            return this._leftItem(index);
          },
        ));
  }

  //左边点击模块
  Widget _leftItem(index) {
    return InkWell(
      onTap: () {
        List data = categoryDataList[index].bxMallSubDto;
        Provider.of<ChildCategory>(context, listen: false)
            .getChildCategory(data);
      },
      child: Container(
        width: ScreenUtil().setWidth(150),
        height: ScreenUtil().setHeight(80),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(categoryDataList[index].mallCategoryName),
      ),
    );
  }
}

// 右边商品内容
class RightCategoryGoodsState extends StatefulWidget {
  RightCategoryGoodsState({Key key}) : super(key: key);

  @override
  _RightCategoryGoodsStateState createState() =>
      _RightCategoryGoodsStateState();
}

class _RightCategoryGoodsStateState extends State<RightCategoryGoodsState> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChildCategory>(
      builder: (context, value, child) {
        return Column(children: [
          this._rightTopNav(value.childCategoryList),
          this._bottomGoods(value.childCategoryList)
        ]);
      },
    );
  }

  //顶部导航栏
  Widget _rightTopNav(data) {
    return Container(
      height: ScreenUtil().setHeight(60),
      width: ScreenUtil().setWidth(600),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return this._titleWidget(data[index].mallSubName);
          }),
    );
  }

  //标题
  Widget _titleWidget(String title) {
    return InkWell(
        onTap: () {},
        child: Container(
            height: ScreenUtil().setHeight(60),
            margin: EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Text(title)));
  }

  // 商品列表
  Widget _bottomGoods(List bxMallSubDto) {
    return Wrap(
        spacing: 2,
        children: bxMallSubDto.map((e) {
          return this._Goods(e);
        }).toList());
  }

  //单个商品展示
  //热门商品
  Widget _Goods(data) {
    return Container(
      padding: EdgeInsets.all(10),
      width: ScreenUtil().setWidth(350),
      child: Column(
        children: [
          Image.network(
            data['image'],
          ),
          Text(data['name'],
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold)),
          Row(children: [
            Text('￥${data['mallPrice']}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text('￥${data['price']}',
                style: TextStyle(
                    color: Colors.black45,
                    decoration: TextDecoration.lineThrough))
          ])
        ],
      ),
    );
  }
}
