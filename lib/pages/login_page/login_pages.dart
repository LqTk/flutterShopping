import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/model/memberLoginInfo.dart';
import 'package:shopping/model/userinfo.dart';
import 'package:shopping/provide/member.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping/router/application.dart';
import 'package:shopping/router/routers.dart';

class LoginPages extends StatefulWidget {
  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,0,30,30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _LoginName(),
          _LoginPassword(),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _LoginRegister(),
                _LoginForgetPassword()
              ],
            ),
          ),
          _LoginButton(context)
        ],
      ),
    );
  }


  Widget _LoginName(){
    return Container(
      child: Row(
        children: <Widget>[
          Icon(Icons.person,size: 40,color: Colors.black26,),
          Expanded(
            child: new TextField(
              controller: _nameController,
              decoration: new InputDecoration(
                  hintText: '请输入用户名'
              ),
              onChanged: (String value){
                print('输入的用户名${value}');
              },
            ),
          )
        ],
      ),
    );
  }
  Widget _LoginPassword(){
    return Container(
      child: Row(
        children: <Widget>[
          Icon(CupertinoIcons.padlock,size: 40,color: Colors.black26,),
          Expanded(
            child: new TextField(
              controller: _passwordController,
              decoration: new InputDecoration(
                  hintText: '请输入密码'
              ),
              onChanged: (String value){
                print('输入的密码${value}');
              },
            ),
          )
        ],
      ),
    );
  }
  Widget _LoginRegister(){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, Routers.registerPage);
      },
      child: Text('注册',style: TextStyle(color: Colors.black26, decoration: TextDecoration.underline),),
    );
  }
  Widget _LoginForgetPassword(){
    return InkWell(
      onTap: (){

      },
      child: Text('忘记密码',style: TextStyle(color: Colors.black26, decoration: TextDecoration.underline),),
    );
  }
  Widget _LoginButton(context){
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: RaisedButton(
        color: Colors.pinkAccent,
        child: Text('登录',style: TextStyle(color: Colors.white),),
        onPressed: (){
          _getInternet(context);
        },
      ),
    );
  }


  void _getInternet(context) async{
    Response response;
    Dio dio = new Dio();
    var formdata = {
      'name': _nameController.text,
      'password': _passwordController.text
    };
    response = await dio.post('http://192.168.2.153:8080//HttpServletTest/Login',data: formdata);
    print(response.data.toString());
    var data = json.decode(response.data.toString());
    MemberLoginInfo loginInfo = MemberLoginInfo();
    if(data['code']==0) {
      loginInfo = MemberLoginInfo.fromJson(data);
      print("loginInfo====" + loginInfo.toString());
      Provide.value<MemberProvider>(context).setLoginInfo(loginInfo);
      Fluttertoast.showToast(msg: '登录成功',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      UserInfo userInfo = new UserInfo(name: _nameController.text, password: _passwordController.text,userId: loginInfo.data.userId);
      Provide.value<MemberProvider>(context).setUserInfo(userInfo);
      preferences.setString("UserInfo", json.encode(userInfo).toString());
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: '登录失败',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
    }
  }

}
