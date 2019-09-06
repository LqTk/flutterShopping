import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

//快速生成model插件：https://javiercbk.github.io/json_to_dart/

//获取商品
Future requestPost(url,{formData}) async{
  try{
    print('开始获取数据..........');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    if(formData==null){
      response = await dio.post(servicePath[url]);
    }else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常。。。');
    }
  }catch(e){
    return print('ERROR:====>${e}');
  }
}

//获取首页主题内容
Future getHomePageContent() async{
  try{
    print('开始获取首页数据..........');

    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    var formData = {
      'lon':'104.072536','lat':'30.540086'
    };
    response = await dio.post(servicePath['homePageContent'],data: formData);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常。。。');
    }
  }catch(e){
    return print('ERROR:====>${e}');
  }
}

//获取火爆专区商品
Future getHomePageBelowConten() async{
  try{
    print('开始获取火爆专区数据..........');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    int page = 1;
    response = await dio.post(servicePath['homePageBelowConten'],data: page);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常。。。');
    }
  }catch(e){
    return print('ERROR:====>${e}');
  }
}