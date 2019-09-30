import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/model/memberLoginInfo.dart';
import 'package:shopping/model/userinfo.dart';
import 'package:shopping/provide/member.dart';
import 'package:shopping/router/application.dart';
import 'package:shopping/router/routers.dart';

class MemberPages extends StatefulWidget {
  @override
  _MemberPagesState createState() => _MemberPagesState();
}

class _MemberPagesState extends State<MemberPages> {

  @override
  void initState() {
    // TODO: implement initState
    _getInternet(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<MemberProvider>(
          builder: (context,child,scope){
            MemberLoginInfo loginInfo = Provide.value<MemberProvider>(context).loginInfo;
            if(loginInfo==null || loginInfo.data==null){
              return Container(
                  child: _topHeader(context,"","")
              );
            }else {
              return Container(
                  child: _topHeader(context,
                      loginInfo.data.picUrl.isEmpty ? "" :'http://192.168.2.153:8080//HttpServletTest/' +loginInfo.data
                          .picUrl, loginInfo.data.name)
              );
            }
          }
      ),
    );
  }


  void _getInternet(context) async{
    Response response;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userInfo = preferences.getString("UserInfo");
    if(userInfo == null || userInfo.isEmpty){
      Provide.value<MemberProvider>(context).setLoginInfo(null);
    }else {
      var temp = json.decode(userInfo.toString());
      Dio dio = new Dio();
      var formdata = {
        'name': temp['name'],
        'password': temp['password']
      };
      response = await dio.post(
          'http://192.168.2.153:8080//HttpServletTest/Login', data: formdata);
      print(response.data.toString());
      var data = json.decode(response.data.toString());
      String dataresult = data['data'].toString();
      MemberLoginInfo loginInfo = new MemberLoginInfo();
      if (dataresult.isNotEmpty) {
        loginInfo = MemberLoginInfo.fromJson(data);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        UserInfo userInfo = new UserInfo(name: loginInfo.data.name, password: temp['password'],userId: loginInfo.data.userId);
        Provide.value<MemberProvider>(context).setUserInfo(userInfo);
        preferences.setString("UserInfo", json.encode(userInfo).toString());
        print("loginInfo====" + loginInfo.toString());
      }
      Provide.value<MemberProvider>(context).setLoginInfo(loginInfo);
    }
  }

  Widget _topHeader(BuildContext context,String headUrl,String name){
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(330),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
          image: new DecorationImage(image: new NetworkImage('http://192.168.2.153:8080//HttpServletTest/bg/bg.jpg'),fit: BoxFit.fitWidth)
      ),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: (){
              name.isEmpty?Application.router.navigateTo(context, Routers.loginPage):Application.router.navigateTo(context, Routers.settingPage);
            },
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: ClipOval(
                    child: headUrl.isEmpty?Icon(CupertinoIcons.person_solid,color: Colors.black45,size: 60,):Image.network(headUrl,height: 60,width: 60,),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  child: name.isEmpty?
                  Text('点击登录',style: TextStyle(color: Colors.black45),):
                  Text(name),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
