import 'package:flutter/material.dart';
import '../model/categorygoodslist.dart';

class CategoryGoodsListProvide with ChangeNotifier{
  List<CategoryListData> goodsList=[];

  setCategoryGoodsList(List list){
    if(list.length==0){
      goodsList.clear();
    }else {
      goodsList = list;
    }
    notifyListeners();
  }

  refreshCategoryGoodsList(List<CategoryListData> list){
    goodsList.addAll(list);
    notifyListeners();
  }
}