import 'package:flutter/material.dart';
import 'package:shopping/model/memberLoginInfo.dart';
import 'package:shopping/model/userinfo.dart';

class MemberProvider with ChangeNotifier{
  MemberLoginInfo loginInfo;
  UserInfo userInfo;

  setLoginInfo(MemberLoginInfo login){
    loginInfo = login;
    notifyListeners();
  }

  setUserInfo(UserInfo user){
    userInfo = user;
    notifyListeners();
  }
}