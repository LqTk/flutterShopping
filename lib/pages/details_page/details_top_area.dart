import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../pages/homemodel/swiper_page.dart';
import '../../progressbar/progress_dialog.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        if(val !=null && Provide
            .value<DetailsInfoProvide>(context)
            .goodsInfo!=null) {
          var goodsInfo = Provide
              .value<DetailsInfoProvide>(context)
              .goodsInfo
              .data
              .goodInfo;
          List<Map> list = [];
          Map map = {'image': goodsInfo.image1};
          map.addAll(map);
          list.add(map);
          if (goodsInfo != null) {
            return Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    _goodsImage(list),
                    _goodsName(goodsInfo.goodsName),
                    _goodsNum(goodsInfo.goodsSerialNumber),
                    _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice),
                  ],
                ),
              );
          } else {
            return Center(child: ProgressDialog().refreshDialog(),);
          }
        } else {
          return Center(child: ProgressDialog().refreshDialog(),);
        }
      },
    );
  }

  Widget _goodsImage(list){
    return SwiperDiy(swiperDateList: list,isCanClick: false,screenHeight: 750,);
  }

  Widget _goodsName(name){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0,top: 10.0),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  //商品编号
  Widget _goodsNum(num){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0,top: 10.0),
      child: Text(
        '编号：${num}',
        style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(25)),
      ),
    );
  }

  Widget _goodsPrice(nowPrice,marketPrice){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0,top: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥${nowPrice}',
            style: TextStyle(color: Colors.red,fontSize: ScreenUtil().setSp(34)),
          ),
          Row(
            children: <Widget>[
              Text('    市场价：',style: TextStyle(fontSize: ScreenUtil().setSp(30)),),
              Text(
                '￥${marketPrice}',
                style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey,fontSize: ScreenUtil().setSp(28)),
              )
            ],
          )
        ],
      ),
    );
  }

}
