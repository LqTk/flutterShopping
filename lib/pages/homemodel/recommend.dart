import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping/router/application.dart';

class Recommend extends StatelessWidget {

  final List recommendList;

  Recommend({Key key,this.recommendList}):super(key: key);

  //标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12)
        )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //推荐商品单独项目
  Widget _item(context,index){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/detail?id=${recommendList[index]['goodsId']}');
      },
      child: Container(
        height: ScreenUtil().setHeight(320),
        width: ScreenUtil().setHeight(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(color: Colors.black12,width: 0.5)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text(
              '￥${recommendList[index]['mallPrice']}',
              style: TextStyle(fontSize: ScreenUtil().setSp(30)),
            ),
            Text('￥${recommendList[index]['price']}',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
              fontSize: ScreenUtil().setSp(26)
            ),)
          ],
        ),
      ),
    );
  }

  //横向列表
  Widget _recommendList(context){
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context,index){
          return _item(context,index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(context)
        ],
      ),
    );
  }
}
