import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;//子类高亮索引
  String subId = '';//小类ID
  int page = 1;//列表页数
  String noMoreText='';//显示没有更多了

  //点击大类时childIndex清零
  setChildCategory(List<BxMallSubDto> list){
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

  //增加page方法
  addPage(){
    page++;
  }

  changeNoMoreText(String str){
    noMoreText = str;
    notifyListeners();
  }
}

