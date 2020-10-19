import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service/service_method.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
        // backgroundColor: Colors.pink,
      ),
      body: FutureBuilder(
          future: getHomePageContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());

              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];

              return Column(
                children: [
                  SwiperDiy(swiperDateList: swiper),
                  HomeHeaderNavigator(navigatorList: navigatorList),
                  AdBanner(adPicture: adPicture),
                  LeaderPhone(
                      leaderImage: leaderImage, leaderPhone: leaderPhone)
                ],
              );
            } else {
              return Center(
                child: Text('加载中......'),
              );
            }
          }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //获取数据
    getHomePageContent().then((value) {
      setState(() {
        this.homePageContent = value;
      });
    });
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
            return Image.network(this.swiperDateList[index]['image']);
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
      height: ScreenUtil().setHeight(250),
      child: GridView.count(
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
