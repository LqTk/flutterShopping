import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo = null;

  bool isLeft = true;
  bool isRight = false;

  //tabbar的切换方法
  changeLeftAndRight(String changeState){
    if(changeState == 'left'){
      isRight = false;
      isLeft = true;
    }else{
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  //从后台获取商品数据
  getGoodsIndo(String id) async{
    var formData = {
      'goodId':id
    };
    await requestPost('getGoodDetailById',formData: formData).then((val){
      var responseData = json.decode(val.toString());
      print(responseData);
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

  //从设置商品数据为空
  setGoodsIndo(){
    goodsInfo = null;
    notifyListeners();
  }


}
