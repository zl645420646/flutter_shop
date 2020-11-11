import 'package:flutter/material.dart';
import 'package:flutterShop/class/category/widget/details_tabbar.dart';
import 'package:flutterShop/class/category/widget/details_web.dart';
import 'package:flutterShop/provide/goodsDetailsProvide.dart';
import 'package:provider/provider.dart';
import 'package:flutterShop/provide/goodsDetailsProvide.dart';

import 'widget/details_top_area.dart';
import 'widget/details_explain.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: FutureBuilder(
            //获取商品详情
            future: this._getBackInfo(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.black12,
                  child: ListView(
                    children: [
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabBar(),
                      DetailsWeb()
                    ],
                  ),
                );
              } else {
                return Container(child: Text('暂无数据'));
              }
            }));
  }

  //获取数据
  Future _getBackInfo(BuildContext context) async {
    await Provider.of<GoodsDetailsProvide>(context, listen: false)
        .getGoodsInfo('123');

    print('加载完成');
    return '完成加载';
  }
}

//头部视图
