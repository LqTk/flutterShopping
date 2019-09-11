import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shopping/model/details.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        DetailsModel goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo;
        List<GoodComments> goodComments = goodsInfo.data.goodComments;
        AdvertesPicture advertesPicture = goodsInfo.data.advertesPicture;
        if(isLeft){
          return Container(
            child: Column(
              children: <Widget>[
                Html(
                  data: goodsDetails,
                ),
                Image.network(advertesPicture.pICTUREADDRESS,width: ScreenUtil().setWidth(750),)
              ],
            ),
          );
        }else {
          if (goodComments.length == 0) {
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    width: ScreenUtil().setWidth(750),
                    padding: EdgeInsets.only(top: 30.0,bottom: 30.0),
                    alignment: Alignment.center,
                    child: Text(
                      '暂无评论哦~',
                      style: TextStyle(color: Colors.black45,fontSize: ScreenUtil().setSp(30)),
                    ),
                  ),
                  Image.network(advertesPicture.pICTUREADDRESS,width: ScreenUtil().setWidth(750),)
                ],
              )
            );
          } else {
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(750),
                    height: ScreenUtil().setHeight(1000),
                    child: ListView.builder(
                      itemCount:goodComments.length+1,
                      itemBuilder: (context,index){
                        if(index==goodComments.length){
                          return
                            Image.network(advertesPicture.pICTUREADDRESS,width: ScreenUtil().setWidth(750),);
                        }else {
                          return _discussView(goodComments[index]);
                        }
                      },
                    ),
                  ),
                ],
              )
            );
          }
        }
      },
    );
  }

  Widget _discussView(GoodComments comments){
    String time = DateTime.fromMillisecondsSinceEpoch(comments.discussTime).toString();
    time = time.split('.')[0];
    return Container(
      padding: EdgeInsets.only(left: 15.0, top: 20.0,bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.black12
          )
        )
      ),
      width: ScreenUtil().setWidth(745),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comments.userName,
            style: TextStyle(color: Colors.black26,fontSize: ScreenUtil().setSp(28)),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
            child: Text(
              comments.comments,
              style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(30)),
            ),
          ),
          Text(
            '${time}',
            style: TextStyle(color: Colors.black26,fontSize: ScreenUtil().setSp(25)),
          ),
        ],
      ),
    );
  }
}
