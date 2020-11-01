import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterShop/provide/child_category.dart';
import 'package:flutterShop/provide/counter.dart';
import 'package:flutterShop/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/category.dart';
import '../../model/categoryMallGoods.dart';
import 'package:provider/provider.dart';

List categoryDataList = [];

int clickedLeftIndex = 0;
String mallCategoryId;

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
      backgroundColor: Colors.black12,
      appBar: AppBar(title: Text('分类')),
      body: Row(
        children: [LeftCategoryNavState(), RightCategoryGoodsState()], //
      ),
    );
  }

  //获取数据
  void _getCategoryList() async {
    await request('getCategory').then((value) {
      // var data = json.decode(value.toString());
      var data = value;

      CategoryModel list = CategoryModel.fromJson(data);
      setState(() {
        categoryDataList = list.data;

        Provider.of<ChildCategory>(context, listen: false)
            .getChildCategory(categoryDataList[0].bxMallSubDto);
      });
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
  void initState() {
    // TODO: implement initState
    super.initState();

    this._getCategoryGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(150),
        decoration: BoxDecoration(
            color: Colors.white,
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
    bool isClicked = false;
    isClicked = index == clickedLeftIndex ? true : false;
    return InkWell(
      onTap: () {
        List data = categoryDataList[index].bxMallSubDto;
        Provider.of<ChildCategory>(context, listen: false)
            .getChildCategory(data);

        this._getCategoryGoodsList(
            mallCategoryId: categoryDataList[index].mallCategoryId);

        setState(() {
          clickedLeftIndex = index;
        });
      },
      child: Container(
        width: ScreenUtil().setWidth(150),
        height: ScreenUtil().setHeight(80),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isClicked ? Colors.black12 : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(categoryDataList[index].mallCategoryName),
      ),
    );
  }

  //获取商品数据
  void _getCategoryGoodsList(
      {String mallCategoryId, String categorySubId}) async {
    var data = {
      'categoryId': mallCategoryId,
      'categorySubId': categorySubId,
      'page': 1
    };

    await request('getMallGoods', formData: data).then((value) {
      CategoryMallGoodListModel list =
          CategoryMallGoodListModel.fromJson(value);
      print('分类商品请求成功--------------------${list.data.length}');

      setState(() {
        Provider.of<ChildCategory>(context, listen: false)
            .getCategoryGoodsList(list.data);
      });
    });
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
          CategoryGoodsListSatate()
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
            return this._titleWidget(index, data[index]);
          }),
    );
  }

  //标题
  Widget _titleWidget(int index, BxMallSubDto data) {
    bool isClick = false;
    var isClickIndex =
        Provider.of<ChildCategory>(context, listen: false).childIndex;

    isClick = isClickIndex == index ? true : false;

    return InkWell(
        onTap: () {
          var mallSubId = data.mallSubId;
          Provider.of<ChildCategory>(context, listen: false)
              .updateChildIndex(index);

          this._getCategoryGoodsList(
              categorySubId: data.mallSubId,
              mallCategoryId: data.mallCategoryId);
        },
        child: Container(
            height: ScreenUtil().setHeight(60),
            margin: EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Text(data.mallSubName,
                style:
                    TextStyle(color: isClick ? Colors.pink : Colors.black))));
  }

  //获取商品数据
  void _getCategoryGoodsList(
      {String mallCategoryId, String categorySubId}) async {
    print('${mallCategoryId}-----${categorySubId}');
    var data = {
      'categoryId': mallCategoryId.toString(),
      'categorySubId': categorySubId.toString(),
      'page': 1
    };

    await request('getMallGoods', formData: data).then((value) {
      CategoryMallGoodListModel list =
          CategoryMallGoodListModel.fromJson(value);
      print('分类商品请求成功--------------------${list.data.length}');

      setState(() {
        Provider.of<ChildCategory>(context, listen: false)
            .getCategoryGoodsList(list.data);
      });
    });
  }
}

//商品分类的商品列表
class CategoryGoodsListSatate extends StatefulWidget {
  CategoryGoodsListSatate({Key key}) : super(key: key);

  @override
  _CategoryGoodsListSatateState createState() =>
      _CategoryGoodsListSatateState();
}

class _CategoryGoodsListSatateState extends State<CategoryGoodsListSatate> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChildCategory>(
      builder: (context, value, child) {
        return Container(
            color: Colors.white,
            width: ScreenUtil().setWidth(600),
            height: ScreenUtil().setHeight(1058),
            child: this._bottomGoods(value.childCategoryGoodsList));
      },
    );
  }

  // 商品列表
  Widget _bottomGoods(List bxMallSubDto) {
    return ListView(
      children: [
        Wrap(
          children: bxMallSubDto.map((e) {
            return this._CategoryGoods(e);
          }).toList(),
        )
      ],
    );
  }

  //热门商品
  Widget _CategoryGoods(CategoryListGoods data) {
    return Container(
      padding: EdgeInsets.all(10),
      width: ScreenUtil().setWidth(300),
      child: Column(
        children: [
          Image.network(
            data.image,
          ),
          Text(data.goodsName,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold)),
          Row(children: [
            Text('￥${data.oriPrice}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text('￥${data.presentPrice}',
                style: TextStyle(
                    color: Colors.black45,
                    decoration: TextDecoration.lineThrough))
          ])
        ],
      ),
    );
  }
}
