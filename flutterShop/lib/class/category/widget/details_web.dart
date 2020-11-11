import 'package:flutter/material.dart';
import 'package:flutterShop/model/goodsDetailsModel.dart';
import 'package:flutterShop/provide/goodsDetailsProvide.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class DetailsWeb extends StatelessWidget {
  const DetailsWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provider.of<GoodsDetailsProvide>(context, listen: false)
        .goodsInfo
        .data
        .goodInfo;
    return Container(
      child: Html(
        data: goodsInfo.goodsDetail,
      ),
    );
  }
}
