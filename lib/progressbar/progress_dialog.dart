import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressDialog{
  Widget refreshDialog(){
    return Container(
      width: ScreenUtil().setWidth(80),
      height: ScreenUtil().setHeight(80),
      child: CircularProgressIndicator(
        backgroundColor: Colors.black12,
        strokeWidth: 3.0,
      ),
    );
  }
}