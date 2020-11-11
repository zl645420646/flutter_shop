import 'package:flutter/material.dart';
import '../service/service_method.dart';

import 'package:flutterShop/model/goodsDetailsModel.dart';

class GoodsDetailsProvide with ChangeNotifier {
  //自定义tabbar
  bool isLeft = true;
  bool isRight = false;

  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }

    notifyListeners();
  }

  //商品详情数据
  GoodsDetailsModel goodsInfo = null;

  getGoodsInfo(String id) async {
    var formData = {'goodId': id};
    await request('getGoodDetailById', formData: formData).then((value) {
      GoodsDetailsModel model = GoodsDetailsModel.fromJson(value);

      goodsInfo = model;

      notifyListeners();
    });
  }
}
