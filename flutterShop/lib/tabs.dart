import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'class/home/home.dart';
import 'class/category/category.dart';
import 'class/cart/cart.dart';
import 'class/mine/mine.dart';

class TabBarPage extends StatefulWidget {
  TabBarPage({Key key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  int _currentPage = 0;
  List _tabs = [HomePage(), CategoryPage(), CartPage(), MinePage()];
  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 此处假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      body: this._tabs[this._currentPage],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: this._currentPage,
          onTap: (value) {
            setState(() {
              this._currentPage = value;
            });
          },
          fixedColor: Colors.pink, //tabBarItem选中颜色
          items: [
            BottomNavigationBarItem(
                title: Text('首页'), icon: Icon(CupertinoIcons.home)),
            BottomNavigationBarItem(
                title: Text('分类'), icon: Icon(CupertinoIcons.search)),
            BottomNavigationBarItem(
                title: Text('购物车'), icon: Icon(CupertinoIcons.shopping_cart)),
            BottomNavigationBarItem(
                title: Text('我的'), icon: Icon(CupertinoIcons.profile_circled))
          ]),
    );
  }
}
