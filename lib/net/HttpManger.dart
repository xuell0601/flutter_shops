//CH
import 'package:dio/dio.dart';
import 'package:flutter_appdfd/net/config.dart';

//获取Banner
Future getHomePageContent() async {
  try {
    print('开始获取首页数据...............');
    Response response;
    Dio dio = new Dio();
    response = await dio.get(Config.GRIDE);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}
//获取楼层
Future getHotContent(int Page) async {
  try {
    print('开始获取===...............');
    Response response;
    Dio dio = new Dio();
    response = await dio.get("https://www.wanandroid.com/article/list/${Page}/json");
    if (response.statusCode == 200) {
      print("${response.data.toString()}");
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}

//获取楼层
Future getCateContent() async {
  try {

    Response response;
    Dio dio = new Dio();
    response = await dio.get("https://api-hmugo-web.itheima.net/api/public/v1/categories");
    if (response.statusCode == 200) {
      print("${response.data.toString()}");
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}