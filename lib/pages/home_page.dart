import 'package:flutter/material.dart';
import 'package:shopping/model/category.dart';
import 'package:shopping/provide/child_category.dart';
import '../service/service_method.dart';
import 'package:shopping/pages/homemodel/swiper_page.dart';
import 'dart:convert';
import 'package:shopping/pages/homemodel/ad_banner.dart';
import 'package:shopping/pages/homemodel/top_navigator.dart';
import 'package:shopping/pages/homemodel/leader_phone.dart';
import 'package:shopping/pages/homemodel/recommend.dart';
import 'package:shopping/pages/homemodel/floor_title.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping/progressbar/progress_dialog.dart';
import 'package:shopping/router/application.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//AutomaticKeepAliveClientMixin 页面保持状态 必须在StatefulWidget里面
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;//页面保持效果 必须在StatefulWidget里面

  Future<dynamic> homePageContent;
  List<Map> hotGoodsList = [];
  int indexPage = 1;

  @override
  void initState() {
    homePageContent = getHomePageContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body: FutureBuilder(
        future: homePageContent,
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navgatorList = (data['data']['category'] as List).cast();
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommendList = (data['data']['recommend'] as List).cast();
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1Content = (data['data']['floor1'] as List).cast();
            List<Map> floor2Content = (data['data']['floor2'] as List).cast();
            List<Map> floor3Content = (data['data']['floor3'] as List).cast();

            return EasyRefresh(
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDateList: swiper,isCanClick: true,screenHeight: 333,),
                  TopNavigator(navigatorList: navgatorList),
                  AdBanner(adPicture: adPicture),
                  LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
                  Recommend(recommendList: recommendList),
                  FloorTitle(picture_address: floor1Title),
                  FloorContent(floorGoodsList: floor1Content),
                  FloorTitle(picture_address: floor2Title),
                  FloorContent(floorGoodsList: floor2Content),
                  FloorTitle(picture_address: floor3Title),
                  FloorContent(floorGoodsList: floor3Content),
                  _hotGoods(),
                ],
              ),
              onRefresh: () async{
                homePageContent = getHomePageContent();
                setState(() {
                  hotGoodsList.clear();
                  indexPage = 1;
                });
              },
              header: ClassicalHeader(
                refreshedText: '刷新成功',
                refreshFailedText: '刷新失败',
                refreshText: '下拉刷新',
                refreshingText: '刷新中...',
                refreshReadyText: '释放刷新',
                infoText: '',
                showInfo: false
              ),
              onLoad: () async{
                var formData = {'page': indexPage};
                await requestPost('homePageBelowConten',formData: formData).then((val){
                  var hotGoodsData = json.decode(val.toString());
                  List<Map> getList = (hotGoodsData['data'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(getList);
                    indexPage++;
                  });
                });
              },
              footer: ClassicalFooter(
                loadText: '上拉加载',
                loadedText: '加载完成',
                loadReadyText: '释放加载',
                loadFailedText: '加载失败',
                loadingText: '加载中...',
                noMoreText: '',
                infoText: '',
                showInfo: false,
                enableInfiniteLoad: false
              ),
            );
          }else{
            return Center(
              child: ProgressDialog().refreshDialog(),
            );
          }
        },
      ),
    );
  }

  Widget _hotTitle(){
    return Container(
      padding: EdgeInsets.all(5.0),
      alignment: Alignment.center,
      child: Text(
        '火爆专区',
        style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  Widget _warpList(){
    if(hotGoodsList.length!=0){
      List<Widget> goodsList = hotGoodsList.map((val){
        return InkWell(
          onTap: (){
            Provide
                .value<DetailsInfoProvide>(context).setGoodsIndo();
//            print('路由跳转》》》》》');
            Application.router.navigateTo(context, '/detail?id=${val['goodsId']}');

          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'],width: ScreenUtil().setWidth(370),),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.pink,fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: goodsList,
      );
    }else{
      return Text('');
    }
  }

  Widget _hotGoods(){
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle(),
          _warpList()
        ],
      ),
    );

  }
}


