import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopping/provide/details_info.dart';
import 'package:shopping/router/application.dart';

//楼层名
class FloorTitle extends StatelessWidget {

  final String picture_address;

  FloorTitle({Key key,this.picture_address}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}

//楼层商品
class FloorContent extends StatelessWidget {
  final List floorGoodsList;


  FloorContent({Key key,this.floorGoodsList}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context)
        ],
      ),
    );
  }

  Widget _firstRow(context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context,floorGoodsList[1]),
            _goodsItem(context,floorGoodsList[2]),
          ],
        ),
      ],
    );
  }

  Widget _otherGoods(context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[3]),
        _goodsItem(context,floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(context,Map goods){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){
          Provide
              .value<DetailsInfoProvide>(context).setGoodsIndo();
          Application.router.navigateTo(context, '/detail?id=${goods['goodsId']}');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}

