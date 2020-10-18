import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 获取首页主体内容
Future getHomePageContent() async {
  print('开始获取首页数据......');

  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROT: ==================>${e}');
  }
}

// 获取首页主体内容
Future getHomePageBelowConten() async {
  print('开始获取首页热门数据......');

  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response =
        await dio.post(servicePath['homePageBelowConten'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROT: ==================>${e}');
  }
}
