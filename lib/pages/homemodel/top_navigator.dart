import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping/router/application.dart';

//顶部导航模块
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  
  TopNavigator({Key key, this.navigatorList}):super(key: key);
  
  Widget _gridViewItemUi(BuildContext context,item){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/detail?id=${item['goodsId']}');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width: ScreenUtil().setHeight(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    if(this.navigatorList.length>10){
      this.navigatorList.removeRange(10, navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,//每行多少个
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _gridViewItemUi(context, item);
        }).toList(),
      ),
    );
  }
}
