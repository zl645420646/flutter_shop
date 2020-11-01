import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../service/service_method.dart';

int currentPage = 1;
List hotGoodsList = [];

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  //防止重复更新界面
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
        // backgroundColor: Colors.pink,
      ),
      body: FutureBuilder(
          future: request('homePageContent',
              formData: {'lon': '115.02932', 'lat': '35.76189'}),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // var data = json.decode(snapshot.data.toString());
              var data = snapshot.data;

              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommend = (data['data']['recommend'] as List).cast();
              List<Map> floorList = [
                {
                  'picture': data['data']['floor1Pic']['PICTURE_ADDRESS'],
                  'list': (data['data']['floor1'] as List).cast()
                },
                {
                  'picture': data['data']['floor2Pic']['PICTURE_ADDRESS'],
                  'list': (data['data']['floor2'] as List).cast()
                },
                {
                  'picture': data['data']['floor3Pic']['PICTURE_ADDRESS'],
                  'list': (data['data']['floor3'] as List).cast()
                }
              ];

              return EasyRefresh(
                child: ListView(
                  children: [
                    SwiperDiy(swiperDateList: swiper),
                    HomeHeaderNavigator(navigatorList: navigatorList),
                    AdBanner(adPicture: adPicture),
                    LeaderPhone(
                        leaderImage: leaderImage, leaderPhone: leaderPhone),
                    GoodsRecommend(recommendList: recommend),
                    FloorGoods(floors: floorList),
                    HotGoodsState()
                  ],
                ),
                onRefresh: () async {
                  print('onRefresh');
                },
                onLoad: () async {
                  print('加载更多');

                  var formData = {'page': currentPage};
                  request('homePageBelowConten', formData: formData)
                      .then((value) {
                    print(value);
                    currentPage++;
                    // var data = json.decode(value.toString());
                    var data = value;

                    List<Map> newGoodList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodList);
                    });
                  });
                },
              );
            } else {
              return Center(
                child: Text('加载中......'),
              );
            }
          }),
    );
  }
}

// 轮播图
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;
  const SwiperDiy({this.swiperDateList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      color: Colors.red,
      child: Swiper(
          pagination: SwiperPagination(),
          itemBuilder: (context, index) {
            return Image.network(
              this.swiperDateList[index]['image'],
              fit: BoxFit.fill,
            );
          },
          itemCount: this.swiperDateList.length),
    );
  }
}

// 首页子导航
// ignore: must_be_immutable
class HomeHeaderNavigator extends StatelessWidget {
  List navigatorList = new List();

  HomeHeaderNavigator({this.navigatorList});

  //单个item
  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了子导航');
      },
      child: Column(
        children: [
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(93),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      padding: EdgeInsets.all(3.0),
      height: ScreenUtil().setHeight(320),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(5.0),
        crossAxisCount: 5,
        children: navigatorList.map((e) {
          return this._gridViewItemUI(context, e);
        }).toList(),
      ),
    );
  }
}

// 广告栏
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话模式
class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长图片
  final String leaderPhone; //店长电话

  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Image.network(this.leaderImage),
        onTap: _launchURL,
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能进行访问，异常';
    }
  }
}

// 商品推荐
class GoodsRecommend extends StatelessWidget {
  final List recommendList;

  const GoodsRecommend({Key key, this.recommendList}) : super(key: key);

  //推荐头部
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 10.0, 0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //单个推荐商品
  Widget _goodsItem(index) {
    return InkWell(
      onTap: () {
        print('object');
      },
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Column(
          children: [
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  //横向滚动列表
  Widget _recommendListWidget() {
    return Container(
      height: ScreenUtil().setHeight(330),
      margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context, index) {
            return _goodsItem(index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [this._titleWidget(), this._recommendListWidget()],
    ));
  }
}

//楼层标题
class FloorTitle extends StatelessWidget {
  final String picture_address;

  const FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(this.picture_address),
    );
  }
}

//每一层的商品
class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  Widget _firstRow() {
    return Row(
      children: [
        this._goodsItem(floorGoodsList[0]),
        Column(
          children: [
            this._goodsItem(floorGoodsList[1]),
            this._goodsItem(floorGoodsList[2])
          ],
        )
      ],
    );
  }

  Widget _twoRow() {
    return Row(
      children: [
        this._goodsItem(floorGoodsList[3]),
        this._goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {},
        child: Image.network(goods['image']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [this._firstRow(), this._twoRow()],
      ),
    );
  }
}

//楼层标题 +楼层商品 (优化)
class FloorGoods extends StatelessWidget {
  List floors;
  FloorGoods({Key key, this.floors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: floors.map((e) {
          return Column(
            children: [
              FloorTitle(picture_address: e['picture']),
              FloorContent(floorGoodsList: e['list'])
            ],
          );
        }).toList(),
      ),
    );
  }
}

// 火爆专区
class HotGoodsState extends StatefulWidget {
  HotGoodsState({Key key}) : super(key: key);

  @override
  _HotGoodsStateState createState() => _HotGoodsStateState();
}

class _HotGoodsStateState extends State<HotGoodsState> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          width: ScreenUtil().setWidth(750),
          color: Color.fromRGBO(245, 245, 245, 1),
          padding: EdgeInsets.all(15),
          child: Text(
            '热门商品',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.pink),
          )),
      Wrap(
        spacing: 2,
        children: hotGoodsList.map((e) {
          return this._HotGoods(e);
        }).toList(),
      )
    ]);
  }

  //热门商品
  Widget _HotGoods(data) {
    return Container(
      padding: EdgeInsets.all(10),
      width: ScreenUtil().setWidth(350),
      child: Column(
        children: [
          Image.network(
            data['image'],
          ),
          Text(data['name'],
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold)),
          Row(children: [
            Text('￥${data['mallPrice']}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text('￥${data['price']}',
                style: TextStyle(
                    color: Colors.black45,
                    decoration: TextDecoration.lineThrough))
          ])
        ],
      ),
    );
  }
}
