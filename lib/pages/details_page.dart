import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';
import '../progressbar/progress_dialog.dart';
import 'details_page/details_explain.dart';
import 'details_page/details_top_area.dart';
import 'details_page/details_tabbar.dart';
import 'details_page/details_web.dart';

class DetailPage extends StatelessWidget {

  final String goodsId;
  Future<dynamic> response;

  DetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          }),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Container(
              child: ListView(
                children: <Widget>[
                  DetailsTopArea(),
                  DetalisExplain(),
                  DetailsTabbar(),
                  DetailsWeb()
                ],
              ),
            );
          }else{
            return ProgressDialog().refreshDialog();
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async{
    await Provide.value<DetailsInfoProvide>(context).getGoodsIndo(goodsId);
    return '完成加载';
  }
}

