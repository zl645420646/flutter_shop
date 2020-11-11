import 'package:flutter/material.dart';
import '../model/category.dart';
import '../model/categoryMallGoods.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = []; //子类
  List<CategoryListGoods> childCategoryGoodsList = []; //分类商品
  int childIndex = 0; //子类索引

  String mallCategoryId = ''; //大类id
  String mallSubId = ''; //子类id

  getChildCategory(List list, String id) {
    childIndex = 0;
    childCategoryList = list;
    mallCategoryId = id;

    notifyListeners();
  }

  getCategoryGoodsList(List list) {
    childCategoryGoodsList = list;

    notifyListeners();
  }

  updateChildIndex(int index, String id) {
    childIndex = index;
    mallSubId = id;

    notifyListeners();
  }
}
