import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopping/model/categorygoodslist.dart';
import 'package:shopping/provide/child_category.dart';
import 'package:shopping/provide/child_category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:shopping/service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  List list =[];

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,categorygoodsList){
        if(categorygoodsList.goodsList.length==0){
          return Text('没有更多了');
        }else {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                topBouncing: false,
                child: ListView.builder(
                  itemCount: categorygoodsList.goodsList.length,
                  itemBuilder: (context, index) {
                    return _goodsListItem(categorygoodsList.goodsList, index);
                  },
                ),
                onLoad: () async{
                  Provide.value<ChildCategory>(context).addPage();
                  _getGoodsList(Provide.value<ChildCategory>(context).childCategoryList[0]);
                },
                footer: ClassicalFooter(
                    loadText: '上拉加载',
                    loadedText: '加载完成',
                    loadReadyText: '释放加载',
                    loadFailedText: '加载失败',
                    loadingText: '加载中...',
                    noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                    infoText: '',
                    showInfo: false,
                    enableInfiniteLoad: false
                ),
              )
            ),
          );
        }
      },
    );
  }

  Widget _goodsImage(index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsName(index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(index){
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${list[index].presentPrice}',
            style: TextStyle(color: Colors.pink,fontSize: ScreenUtil().setSp(28)),
          ),
          Text(
            '￥${list[index].oriPrice}',
            style: TextStyle(decoration:TextDecoration.lineThrough,color: Colors.black45,fontSize: ScreenUtil().setSp(28)),
          )
        ],
      ),
    );
  }

  Widget _goodsListItem(newList,index){
    list = newList;
    return InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: Colors.black12,width: 1.0)
              )
          ),
          child: Row(
            children: <Widget>[
              _goodsImage(index),
              Column(
                children: <Widget>[
                  _goodsName(index),
                  _goodsPrice(index)
                ],
              )
            ],
          ),
        )
    );
  }

  void _getGoodsList(categoryDate) async{
    var data = {
      'categoryId':categoryDate.mallCategoryId,
      'categorySubId':categoryDate.mallSubId,
      'page':Provide.value<ChildCategory>(context).page
    };

    await requestPost('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if(goodsList.data == null){
        Fluttertoast.showToast(
          msg: '没有更多了',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(24)
        );
        Provide.value<ChildCategory>(context).changeNoMoreText('没有更多了');
      }else {
        Provide.value<CategoryGoodsListProvide>(context).refreshCategoryGoodsList(
            goodsList.data);
      }
    });
  }

}
