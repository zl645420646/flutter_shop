import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              List swiper = (data['data']['slides'] as List).cast();

              return Column(
                children: [
                  SwiperDiy(
                    swiperDateList: swiper,
                  ),
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
      print(value);
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
      color: Color.fromRGBO(245, 245, 245, 1),
      child: Swiper(
          pagination: SwiperPagination(),
          itemBuilder: (context, index) {
            return Image.network(this.swiperDateList[index]['image']);
          },
          itemCount: this.swiperDateList.length),
    );
  }
}
