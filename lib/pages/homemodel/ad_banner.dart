import 'package:flutter/material.dart';

//广告模块
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key,this.adPicture}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}
