import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopping/model/category.dart';
import 'package:shopping/model/categorygoodslist.dart';
import 'package:shopping/provide/child_category.dart';
import 'package:shopping/provide/child_category_goods_list.dart';
import 'package:shopping/service/service_method.dart';


class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List list = [];
  var listIndex = 0;


  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1,color: Colors.black12))
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index){
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(index){
    bool isClick = false;
    isClick = (index==listIndex)?true:false;
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).setChildCategory(childList);
        Provide.value<CategoryGoodsListProvide>(context).setCategoryGoodsList([]);
        _getGoodsList(list[index],context);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0, top: 15.0),
        decoration: BoxDecoration(
            color: isClick?Colors.black12: Colors.white,
            border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12)
            )
        ),
        child: Text(list[index].mallCategoryName, style: TextStyle(fontSize: ScreenUtil().setSp(30)),),
      ),
    );
  }


  void _getGoodsList(CategoryDate categoryDate,context) async{
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


  void _getCategory() async{
    await requestPost('getCategory').then((val){
      var data = json.decode(val.toString());
      Category category = Category.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategory>(context).setChildCategory(list[0].bxMallSubDto);
      _getGoodsList(list[0],context);
    });
  }
}
