import 'package:flutter/material.dart';
import 'package:flutterShop/provide/goodsDetailsProvide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsTabBar extends StatelessWidget {
  const DetailsTabBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        width: ScreenUtil().setWidth(750),
        child: Consumer<GoodsDetailsProvide>(
          builder: (context, value, child) {
            return Row(
              children: [
                _myTabBarLeft(
                    context,
                    Provider.of<GoodsDetailsProvide>(context, listen: false)
                        .isLeft),
                _myTabBarRight(
                    context,
                    Provider.of<GoodsDetailsProvide>(context, listen: false)
                        .isRight)
              ],
            );
          },
        ));
  }

  //左边  详情
  Widget _myTabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provider.of<GoodsDetailsProvide>(context, listen: false)
            .changeLeftAndRight('left');
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isLeft ? Colors.pink : Colors.white))),
        child: Text(
          '详情',
          style: TextStyle(
            color: isLeft ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  //右边  评论
  Widget _myTabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provider.of<GoodsDetailsProvide>(context, listen: false)
            .changeLeftAndRight('right');
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isRight ? Colors.pink : Colors.white))),
        child: Text(
          '评论',
          style: TextStyle(
            color: isRight ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }
}
