import 'package:flutter/material.dart';
import 'package:flutterShop/provide/cart_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartBottom extends StatelessWidget {
  const CartBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      color: Colors.white,
      child: Row(
        children: [_checkAllBtn(), _allPriceArea(), _toPayBtn()],
      ),
    );
  }

  //全选box
  Widget _checkAllBtn() {
    return Row(
      children: [
        Checkbox(activeColor: Colors.pink, value: false, onChanged: (value) {}),
        Text('全选',
            style: TextStyle(
                color: Colors.black87, fontSize: ScreenUtil().setSp(28)))
      ],
    );
  }

  //合计价格
  Widget _allPriceArea() {
    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '￥1992.00',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24), color: Colors.pink),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
            ),
          )
        ],
      ),
    );
  }

  //立即购买
  Widget _toPayBtn() {
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3)),
          child: Consumer<CartProvide>(builder: (context, value, child) {
            int goodsNumber =
                Provider.of<CartProvide>(context, listen: false).goodsNumber;
            return Text(
              '结算(${goodsNumber})',
              style: TextStyle(color: Colors.white),
            );
          }),
        ),
      ),
    );
  }
}
