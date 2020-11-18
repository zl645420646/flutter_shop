import 'package:flutter/material.dart';
import 'package:flutterShop/model/goodsDetailsModel.dart';
import 'package:flutterShop/provide/goodsDetailsProvide.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsWeb extends StatelessWidget {
  const DetailsWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provider.of<GoodsDetailsProvide>(context, listen: false)
        .goodsInfo
        .data
        .goodInfo;

    return Consumer<GoodsDetailsProvide>(builder: (context, value, child) {
      bool isLeft =
          Provider.of<GoodsDetailsProvide>(context, listen: false).isLeft;
      if (isLeft) {
        return Container(
          width: ScreenUtil().setWidth(750),
          child: Html(data: goodsInfo.goodsDetail),
        );
      } else {
        return Container(
          width: ScreenUtil().setWidth(750),
          alignment: Alignment.center,
          child: Text('暂无评论'),
        );
      }
    });
  }
}
