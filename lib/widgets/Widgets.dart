import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
/*
class NetImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
  Future _child(url,size,{formData}) async{
    try{
    print('开始获取数据..........');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    if(formData==null){
      response = await dio.post(url);
    }else {
      response = await dio.post(url, data: formData);
    }
    if(response.statusCode==200){
      return '连接成功';
    }else{
      throw Exception('后端接口出现异常。。。');
    }
    }catch(e){
      return '连接失败';
    }
  }

}*/
Widget NetImage(url,size){
  var child = _child(url,size);
  child.then((val){
    String string = val.toString();
    print(string);
    if(string=="连接成功"){
      return Image.network(url,height: size,width: size,);
    }
    return Icon(CupertinoIcons.person_solid,color: Colors.black45,size: size,);
  });
}

Future _child(url,size,{formData}) async{
  try{
    print('开始获取数据..........');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    if(formData==null){
      response = await dio.post(url);
    }else {
      response = await dio.post(url, data: formData);
    }
    if(response.statusCode==200){
      return '连接成功';
    }else{
      return '连接失败';
    }
  }catch(e){
    return '连接失败';
  }
}

