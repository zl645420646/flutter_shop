import 'package:flutter/material.dart';
import 'package:flutterShop/class/cart/widget/cart_count.dart';
import 'package:flutterShop/model/cartModel.dart';
import 'package:flutterShop/provide/cart_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final CartModel item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: [
          _cartCheckBtn(item, context),
          _goodsImage(item),
          _goodsName(item),
          _goodsPrice(item, context)
        ],
      ),
    );
  }

  //可选按钮
  Widget _cartCheckBtn(CartModel item, BuildContext context) {
    return Checkbox(
        activeColor: Colors.pink,
        value: item.selected,
        onChanged: (value) {
          Provider.of<CartProvide>(context, listen: false)
              .updateGoodsState(item.goodsId);
        });
  }

  //商品图片
  Widget _goodsImage(CartModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(item.image),
    );
  }

  //商品名称
  Widget _goodsName(CartModel item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      alignment: Alignment.topLeft,
      child: Column(
        children: [Text(item.goodsName), CartCount()],
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(CartModel item, BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.topRight,
      child: Column(
        children: [
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provider.of<CartProvide>(context, listen: false)
                    .deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                size: 30,
                color: Colors.black38,
              ),
            ),
          )
        ],
      ),
    );
  }
}
