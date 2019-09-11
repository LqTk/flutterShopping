import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shopping/model/categorygoodslist.dart';
import 'package:shopping/provide/child_category_goods_list.dart';
import 'package:shopping/service/service_method.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<CategoryDate> cateList = [];
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;//子类高亮索引
  String subId = '';//小类ID
  int page = 1;//列表页数
  String noMoreText='';//显示没有更多了
  int lastIndex=0;//商品分类索引

  setCategoryDataList(List<CategoryDate> list){
    cateList = list;
    notifyListeners();
  }

  //点击大类时childIndex清零
  setChildCategory(List<BxMallSubDto> list,last){
    lastIndex = last;
    childIndex = 0;
    page = 1;
    noMoreText = '';
    if(list.length>0) {
      BxMallSubDto all = BxMallSubDto();
      all.mallSubId = '';
      all.mallCategoryId = list[0].mallCategoryId;
      all.mallSubName = '全部';
      all.comments = 'null';
      childCategoryList = [all];
      childCategoryList.addAll(list);
    }else{
      BxMallSubDto all = BxMallSubDto();
      all.mallSubId = '';
      all.mallCategoryId = '';
      all.mallSubName = '全部';
      all.comments = 'null';
      childCategoryList.clear();
    }
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index,String id){
    page = 1;
    noMoreText = '';
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  navCategory(int index,context){
    setChildCategory(cateList[index].bxMallSubDto,index);
    _getGoodsList(cateList[index].bxMallSubDto[0],context);
  }

  //增加page方法
  addPage(){
    page++;
  }

  changeNoMoreText(String str){
    noMoreText = str;
    notifyListeners();
  }

  void _getGoodsList(categoryDate,context) async{
    var data = {
      'categoryId':categoryDate.mallCategoryId,
      'categorySubId':'',
      'page':1
    };

    await requestPost('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if(goodsList.data==null){
        Provide.value<CategoryGoodsListProvide>(context).setCategoryGoodsList(
            []);
      }else {
        Provide.value<CategoryGoodsListProvide>(context).setCategoryGoodsList(
            goodsList.data);
      }
    });
  }
}

