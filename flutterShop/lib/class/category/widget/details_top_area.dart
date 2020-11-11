import 'package:flutter/material.dart';
import 'package:flutterShop/provide/goodsDetailsProvide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsTopArea extends StatelessWidget {
  const DetailsTopArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GoodsDetailsProvide>(
      builder: (context, value, child) {
        var goodsInfo = Provider.of<GoodsDetailsProvide>(context, listen: false)
            .goodsInfo
            .data
            .goodInfo;
        if (goodsInfo != null) {
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsCode(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
              ],
            ),
          );
        } else {
          return Text('正在加载中');
        }
      },
    );
  }

  //商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(750),
    );
  }

  //商品名称
  Widget _goodsName(name) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
      width: ScreenUtil().setWidth(750),
      child: Text(
        name,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(30), fontWeight: FontWeight.bold),
      ),
    );
  }

  //商品编号
  Widget _goodsCode(code) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
        width: ScreenUtil().setWidth(750),
        child: Text(
          '编号:${code}',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(20), color: Colors.black54),
        ));
  }

  //商品售卖价格和市场价
  Widget _goodsPrice(todayPrice, oldPrice) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
      child: Row(
        children: [
          Text(
            '￥${todayPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(35),
              color: Colors.orange,
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(80)),
          Text(
            '市场价：',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(25), color: Colors.black87),
          ),
          SizedBox(width: ScreenUtil().setWidth(20)),
          Text(
            '￥${oldPrice}',
            style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
                fontSize: ScreenUtil().setSp(25)),
          )
        ],
      ),
    );
  }
}
