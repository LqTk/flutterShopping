import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:provide/provide.dart';
import 'package:shopping/config/service_url.dart';
import 'package:shopping/model/memberLoginInfo.dart';
import 'package:shopping/provide/member.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPages extends StatefulWidget {
  @override
  _RegisterPagesState createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {

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
  Widget _LoginButton(context){
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: RaisedButton(
        color: Colors.pinkAccent,
        child: Text('注册',style: TextStyle(color: Colors.white),),
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
    response = await dio.post(myServicePath['registerPath'],data: formdata);
    print(response.data.toString());
    var data = json.decode(response.data.toString());
    if(data['code']==0) {
      Fluttertoast.showToast(msg: data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
    }
  }

}
