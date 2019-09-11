import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:shopping/model/cartInfo.dart';

class CartProvide with ChangeNotifier{
  String cartString='[]';
  List<CartInfoModel> cartList = [];
  double allPrice=0;//总价
  int alChecklGoodsCount = 0;//商品选中的数量
  bool isAllCheck = true;//是否全选
  int allGoodsCount = 0;//总共的数据

  save(goodsId,goodsName,count,price,presentPrice,images) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    var temp = cartString==null?[]:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival= 0;
    alChecklGoodsCount = 0;
    allGoodsCount = 0;
    allPrice = 0;
    tempList.forEach((item){
      if(item['goodsId']==goodsId){
        tempList[ival]['count']=item['count']+1;
        cartList[ival].count++;
        isHave = true;
      }
      if(item['isCheck']) {
        allPrice += cartList[ival].count * cartList[ival].price;
        alChecklGoodsCount += cartList[ival].count;
      }
      allGoodsCount +=cartList[ival].count;
      ival++;
    });

    if(!isHave){
      Map<String,dynamic> newGoods = {
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'presentPrice':presentPrice,
        'images':images,
        'isCheck':false,
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));

      allGoodsCount +=count;
    }

    cartString = json.encode(tempList).toString();
    preferences.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cartInfo');
    cartList=[];

    notifyListeners();
  }

  getCartInfo() async{
    alChecklGoodsCount = 0;
    allGoodsCount = 0;
    allPrice = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    cartList=[];
    if(cartString == null){
      cartList=[];
    }else{
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      isAllCheck = true;
      tempList.forEach((item){
        cartList.add(CartInfoModel.fromJson(item));
        if(item['isCheck']) {
          allPrice = allPrice + item['count']*item['price'];
          alChecklGoodsCount+=item['count'];
        }else{
          isAllCheck = false;
        }
        allGoodsCount+=item['count'];
      });
    }

    notifyListeners();

  }

  //删除单个商品
 deleteOneGoods(String goodsId) async{
   cartString = '';
   SharedPreferences preferences = await SharedPreferences.getInstance();
   cartString = preferences.getString('cartInfo');
   var temp = cartString==null?[]:json.decode(cartString.toString());
   List<Map> tempList = (temp as List).cast();
   int tempIndex= 0;
   int delIndex= 0;
   tempList.forEach((item){
     if(item['goodsId']==goodsId){
        delIndex = tempIndex;
     }
     tempIndex++;
   });
   tempList.removeAt(delIndex);
   cartString = json.encode(tempList).toString();
   preferences.setString('cartInfo', cartString);

   await getCartInfo();
 }

 changeCheckState(CartInfoModel cartItem) async{
   cartString = '';
   SharedPreferences preferences = await SharedPreferences.getInstance();
   cartString = preferences.getString('cartInfo');
   var temp = cartString==null?[]:json.decode(cartString.toString());
   List<Map> tempList = (temp as List).cast();
   int tempIndex= 0;
   int changeIndex= 0;
   tempList.forEach((item){
     if(item['goodsId']==cartItem.goodsId){
       changeIndex = tempIndex;
     }
     tempIndex++;
   });
   tempList[changeIndex]=cartItem.toJson();
   cartString = json.encode(tempList).toString();
   preferences.setString('cartInfo', cartString);
   await getCartInfo();
 }

 //点击全选操作
  changeAllCheckBtnState(bool isCheck) async{
    cartString = '';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    var temp = cartString==null?[]:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    List<Map> newList = [];
    for(var item in tempList){
      var newItem = item;
      newItem['isCheck']=isCheck;
      newList.add(newItem);
    }
    cartString = json.encode(newList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }


  //加减商品数量
  changeGoodsCount(String goodsId,String todo) async{
    cartString = '';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    var temp = cartString==null?[]:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    int tempIndex= 0;
    int changeIndex= 0;
    tempList.forEach((item){
      if(item['goodsId']==goodsId){
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if(todo=='add'){
      tempList[changeIndex]['count']++;
    }else{
      if(tempList[changeIndex]['count']>1){
        tempList[changeIndex]['count']--;
      }
    }
    cartString = json.encode(tempList).toString();
    preferences.setString('cartInfo', cartString);

    await getCartInfo();
  }

}