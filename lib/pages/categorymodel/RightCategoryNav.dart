import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopping/model/category.dart';
import 'package:shopping/model/categorygoodslist.dart';
import 'package:shopping/provide/child_category.dart';
import 'package:shopping/provide/child_category_goods_list.dart';
import 'package:shopping/service/service_method.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context,child,childCategory){
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1,color: Colors.black12)
              )
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context,item){
              return _rightInkWell(item,childCategory.childCategoryList[item]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(int index, BxMallSubDto item){
    bool isClick = false;
    isClick = (index==Provide.value<ChildCategory>(context).childIndex)?true:false;
    return InkWell(
      onTap: (){
        Provide.value<ChildCategory>(context).changeChildIndex(index,item.mallSubId);
        Provide.value<CategoryGoodsListProvide>(context).setCategoryGoodsList([]);
        _getGoodsList(item);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: isClick?TextStyle(fontSize: ScreenUtil().setSp(28),color: Colors.red):TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }



  void _getGoodsList(categoryDate) async{
    var data = {
      'categoryId':categoryDate.mallCategoryId,
      'categorySubId':categoryDate.mallSubId,
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
