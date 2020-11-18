import 'package:flutter/material.dart';
import 'package:flutterShop/provide/cart_provide.dart';
import 'package:flutterShop/provide/goodsDetailsProvide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsBottm extends StatelessWidget {
  const DetailsBottm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provider.of<GoodsDetailsProvide>(context, listen: false).goodsInfo.data;

    var goodsId = goodsInfo.goodInfo.goodsId;
    var goodsName = goodsInfo.goodInfo.goodsName;
    var price = goodsInfo.goodInfo.oriPrice;
    var image = goodsInfo.goodInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(80),
      color: Colors.white,
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              await Provider.of<CartProvide>(context, listen: false)
                  .getCartList();
            },
            child: Container(
              width: ScreenUtil().setWidth(110),
              alignment: Alignment.center,
              child: Icon(Icons.shopping_cart, size: 35, color: Colors.red),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provider.of<CartProvide>(context, listen: false)
                  .save(goodsId, goodsName, 1, price, image);
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.green,
              child: Text('加入购物车',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(20))),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provider.of<CartProvide>(context, listen: false).delete();
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              color: Colors.orange,
              child: Text('立即购买',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(20))),
            ),
          ),
        ],
      ),
    );
  }
}
