import 'package:flutter/material.dart';
import 'package:flutterShop/class/cart/widget/cart_bottom.dart';
import 'package:flutterShop/class/cart/widget/cart_item.dart';
import 'package:flutterShop/model/cartModel.dart';
import 'package:flutterShop/provide/cart_provide.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        appBar: AppBar(title: Text('购物车')),
        body: FutureBuilder(
            future: _getCartInfo(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List cartList =
                    Provider.of<CartProvide>(context, listen: false).cartList;
                print('购物车数据-------${cartList}');

                return Stack(
                  children: [
                    Consumer<CartProvide>(builder: (context, value, child) {
                      cartList =
                          Provider.of<CartProvide>(context, listen: false)
                              .cartList;
                      return ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (context, index) {
                            return CartItem(cartList[index]);
                          });
                    }),
                    Positioned(bottom: 0, left: 0, child: CartBottom())
                  ],
                );
              } else {
                return Text('正在加载购物车');
              }
            }));
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provider.of<CartProvide>(context, listen: false).getCartList();
    print('------------------------------');
    return '购物车数据获取成功';
  }
}
