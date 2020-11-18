import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterShop/model/cartModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide extends ChangeNotifier {
  //空数据json格式
  String cartString = '[]';
  List<CartModel> cartList = [];

  //选中的商品总数量
  int goodsNumber = 0;

  //save
  save(goodsId, goodsName, count, price, image) async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    cartString = prefes.getString('cartInfo');

    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();

    print('解析后的list = ${tempList}');

    bool isHave = false;
    tempList.forEach((element) {
      if (element['goodsId'] == goodsId) {
        element['count']++;

        isHave = true;
      }
    });

    //如果goodsId 不相同，新增
    if (!isHave) {
      tempList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'image': image,
        'selected': false
      });
    }

    cartString = json.encode(tempList).toString();

    print(cartString);

    prefes.setString('cartInfo', cartString);

    getCartList();
  }

  //delete
  delete() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    prefes.remove('cartInfo');
    print('=================清空成功');
    notifyListeners();
  }

  //删除单个商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    cartString = prefes.getString('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int index = 0;
    int deleteIndex = 0;
    tempList.forEach((element) {
      if (element['goodsId'] == goodsId) {
        deleteIndex = index;
      }
      index++;
    });

    tempList.removeAt(deleteIndex);

    cartString = json.encode(tempList).toString();

    prefes.setString('cartInfo', cartString);

    getCartList();
  }

  //获取总共选中的商品数量
  getGoodsNum() async {
    goodsNumber = 0;
    SharedPreferences prefes = await SharedPreferences.getInstance();
    cartString = prefes.getString('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    tempList.forEach((element) {
      if (element['selected'] == true) {
        goodsNumber++;
      }
    });

    notifyListeners();
  }

  //修改某个商品是否选中
  updateGoodsState(String goodsId) async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    cartString = prefes.getString('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    tempList.forEach((element) {
      if (element['goodsId'] == goodsId) {
        element['selected'] = !element['selected'];
      }
    });

    cartString = json.encode(tempList).toString();

    prefes.setString('cartInfo', cartString);

    getCartList();
    getGoodsNum();
  }

  //get
  getCartList() async {
    //每次获取购物车清空数组
    cartList = [];

    SharedPreferences prefes = await SharedPreferences.getInstance();
    cartString = prefes.getString('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    tempList.forEach((element) {
      cartList.add(CartModel.fromJson(element));
    });

    notifyListeners();
  }
}
