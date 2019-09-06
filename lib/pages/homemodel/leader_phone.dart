import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderPhone extends StatelessWidget {

  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({Key key,this.leaderImage, this.leaderPhone}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){
          print('拨打电话');
          _launchUrl();
        },
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchUrl() async{
    String url = 'tel:'+leaderPhone;
//    String url = 'http://flutter.dev';
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'url不能进行访问，异常';
    }

  }
}
