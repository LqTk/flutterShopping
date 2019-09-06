import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../pages/homemodel/swiper_page.dart';
import '../../progressbar/progress_dialog.dart';

class DetalisExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _goodsDecortion();
  }

  Widget _goodsDecortion(){
    return Container(
      width: ScreenUtil().setWidth(745),
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      child: Text(
        '说明：>急速送达>正品保证',
        style: TextStyle(color: Colors.redAccent, fontSize: ScreenUtil().setSp(25)),
      ),
    );
  }

}
