import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping/router/application.dart';

//首页轮播图
class SwiperDiy extends StatelessWidget {

  final List swiperDateList;
  final bool isCanClick;
  final int screenHeight;
  SwiperDiy({Key key, this.swiperDateList, this.isCanClick, this.screenHeight}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(screenHeight),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: (){
              if(isCanClick) {
                Application.router.navigateTo(
                    context, '/detail?id=${swiperDateList[index]['goodsId']}');
              }
            },
            child: Image.network(swiperDateList[index]['image'],fit: BoxFit.fitWidth,width: ScreenUtil().setWidth(745),),
          );
        },
        itemCount: swiperDateList.length,
        pagination: (swiperDateList.length==1)?null:SwiperPagination(),//小圆点
        autoplay: true,
        loop: !(swiperDateList.length==1),
      ),
    );
  }
}