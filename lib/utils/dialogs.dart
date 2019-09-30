import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/model/memberLoginInfo.dart';
import 'package:shopping/model/userinfo.dart';
import 'package:shopping/provide/member.dart';

class Dialogs {
  TextEditingController editingController;

  TextEditingController oldEditingController;
  TextEditingController nowEditingController;

  SetEdColler(TextEditingController editingController){
    this.editingController = editingController;
  }

  SetPassColler(TextEditingController oldEditingController, TextEditingController nowEditingController){
    this.oldEditingController = oldEditingController;
    this.nowEditingController = nowEditingController;
  }

  InputNickNameDialog(String nickName, BuildContext context){

    return AlertDialog(
      title: Text('输入昵称'),
      content: TextField(
        controller: editingController,
        decoration: new InputDecoration(
          hintText: nickName
        ),
      ),
      actions: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.black26,
              child: Text('取消'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              color: Colors.black26,
              child: Text('确定'),
              onPressed: (){
                _upDataNickName(editingController.text, context);
              },
            ),
          ],
        )
      ],
    );
  }

  InputNewNickNameDialog(String nickName, BuildContext context){
    return SimpleDialog(
      title: Container(
        child: Center(
          child: Text('输入昵称'),
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: editingController,
                decoration: new InputDecoration(
                    hintText: nickName
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 30),
              child: RaisedButton(
                color: Colors.black26,
                child: Text('取消',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            RaisedButton(
              color: Colors.pinkAccent,
              child: Text('确定',style: TextStyle(color: Colors.white),),
              onPressed: (){
                _upDataNickName(editingController.text, context);
              },
            ),
          ],
        )
      ],
    );
  }

  InputNewPasswordDialog(BuildContext context){
    return SimpleDialog(
      title: Container(
        child: Center(
          child: Text('密码修改'),
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: oldEditingController,
                decoration: new InputDecoration(
                    hintText: '请输入原密码'
                ),
              ),
              TextField(
                controller: nowEditingController,
                decoration: new InputDecoration(
                    hintText: '请输入新密码'
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 30),
              child:
              RaisedButton(
                color: Colors.black26,
                child: Text('取消',style: TextStyle(color:Colors.white),),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              child: RaisedButton(
                color: Colors.pinkAccent,
                child: Text('确定',style: TextStyle(color:Colors.white),),
                onPressed: (){
                  _upDataPassword(oldEditingController.text, nowEditingController.text, context);
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  _upDataNickName(String nickName,BuildContext context) async{
    editingController.text = "";
    if(nickName.isEmpty){
      Fluttertoast.showToast(msg: "昵称不能为空",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userInfo = preferences.getString("UserInfo");
    var temp = json.decode(userInfo.toString());
    Navigator.pop(context);
    showDialog(context: context,builder: (_){
      return Container(
        width: ScreenUtil().setWidth(20),
        height: ScreenUtil().setHeight(20),
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.pinkAccent,
            strokeWidth: 3.0,
          ),
        ),
      );
    });
    Dio dio = new Dio();
    var formdata = {
      'nickName': nickName,
      'password': temp['password'],
      'userId': temp['userId'],
      'nowPassWord':''
    };
    var response = await dio.post('http://192.168.2.153:8080//HttpServletTest/ChangeName',data: formdata);
    var resultChange = json.decode(response.data.toString());
    if(resultChange['code']==0){
      MemberLoginInfo loginInfo=Provide.value<MemberProvider>(context).loginInfo;
      loginInfo.data.name = nickName;
      Provide.value<MemberProvider>(context).setLoginInfo(loginInfo);
      UserInfo userInfo = new UserInfo(name: loginInfo.data.name, password: temp['password'],userId: loginInfo.data.userId);
      preferences.setString("UserInfo", json.encode(userInfo).toString());
      Fluttertoast.showToast(msg: "昵称修改成功",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: "昵称修改失败",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      Navigator.pop(context);
    }
  }

  _upDataPassword(String oldPassword, String nowPassword,BuildContext context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userInfo = preferences.getString("UserInfo");
    var temp = json.decode(userInfo.toString());
    if(oldPassword.isEmpty){
      Fluttertoast.showToast(msg: "请输入旧密码",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }
    if(oldPassword!=temp['password']){
      Fluttertoast.showToast(msg: "原密码不正确",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
      return;
    }else {
      if(nowPassword.isEmpty){
        Fluttertoast.showToast(msg: "新密码不能为空",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
        return;
      }
      oldEditingController.text = "";
      nowEditingController.text = "";
      Dio dio = new Dio();
      var formdata = {
        'nickName': temp['name'],
        'password': temp['password'],
        'userId': temp['userId'],
        'nowPassWord': nowPassword
      };
      Navigator.pop(context);
      showDialog(context: context,builder: (_){
        return Container(
          width: ScreenUtil().setWidth(20),
          height: ScreenUtil().setHeight(20),
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.pinkAccent,
              strokeWidth: 3.0,
            ),
          ),
        );
      });
      var response = await dio.post(
          'http://192.168.2.153:8080//HttpServletTest/ChangeName',
          data: formdata);
      var resultChange = json.decode(response.data.toString());
      if (resultChange['code'] == 0) {
        UserInfo userInfo = new UserInfo(
            name: temp['name'], password: nowPassword, userId: temp['userId']);
        preferences.setString("UserInfo", json.encode(userInfo).toString());
        Fluttertoast.showToast(msg: "密码修改成功",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "密码修改失败",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
        Navigator.pop(context);
      }
    }
  }
}