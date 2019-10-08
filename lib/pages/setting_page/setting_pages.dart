import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provide/provide.dart';
import 'package:shopping/model/memberLoginInfo.dart';
import 'package:shopping/progressbar/progress_dialog.dart';
import 'package:shopping/provide/member.dart';
import 'package:shopping/router/application.dart';
import 'package:shopping/utils/dialogs.dart';

class SettingPages extends StatefulWidget {
  @override
  _SettingPagesState createState() => _SettingPagesState();
}

class _SettingPagesState extends State<SettingPages> {


  TextEditingController editingController = new TextEditingController();

  TextEditingController oldEditingController = new TextEditingController();
  TextEditingController nowEditingController = new TextEditingController();


  var imagePath;

  @override
  Widget build(BuildContext context) {
    return Provide<MemberProvider>(
      builder: (context,child,scope){
        MemberLoginInfo loginInfo = Provide.value<MemberProvider>(context).loginInfo;
        return Container(
          child: ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  leading: ClipOval(
                    child: loginInfo==null || loginInfo.data==null || loginInfo.data.picUrl.isEmpty ? Icon(CupertinoIcons.person_solid,color: Colors.black45,size: 30,) : Image.network('http://192.168.2.153:8080//HttpServletTest/ImageById?id=${loginInfo.data
                        .userId}&picUrl=${loginInfo.data.picUrl}',width: 30.0,height: 30.0,),
                  ),
                  title: Text('修改头像'),
                  onTap: (){
                    ShowBottomChooes(context);
                  },
                ),
                ListTile(
                  leading:Icon(Icons.person,size: 30,),
                  title: Text('修改昵称'),
                  trailing: Text(loginInfo==null || loginInfo.data==null?'':loginInfo.data.name),
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (_){
                          Dialogs dialog = new Dialogs();
                          dialog.SetEdColler(editingController);
                          return dialog.InputNewNickNameDialog(loginInfo.data.name,context);
                        }
                    );
                  },
                ),
                ListTile(
                  leading:Icon(CupertinoIcons.padlock,size: 30,),
                  title: Text('修改密码'),
                  onTap: (){
                    print("修改密码");
                    showDialog(
                      context: context,
                      builder: (_){
                        Dialogs dialog = new Dialogs();
                        dialog.SetPassColler(oldEditingController, nowEditingController);
                        return dialog.InputNewPasswordDialog(context);
                      }
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.keyboard_backspace,size: 30),
                  title: Text('退出登录'),
                  onTap: (){
                    Provide.value<MemberProvider>(context).setLoginInfo(null);
                    Navigator.pop(context);
                  },
                ),
              ]
            ).toList()
          ),
        );
      },
    );
  }


  Future ShowBottomChooes(context) async{
    final option = await showModalBottomSheet(
        context:context,
        builder: (context){
          return Container(
            height: ScreenUtil().setHeight(500),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('相机',textAlign: TextAlign.center,),
                    onTap: (){
                      Fluttertoast.showToast(msg: '从相机选择',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
                      _takePhoto();
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('相册',textAlign: TextAlign.center,),
                    onTap: (){
                      Fluttertoast.showToast(msg: '从相册选择',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
                      _openGallery();
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.arrow_back_ios),
                    title: Text('取消',textAlign: TextAlign.center,),
                    onTap: (){
                      Fluttertoast.showToast(msg: '取消',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  _openGallery() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null)
    _upLoadImage(image);
  }

  _takePhoto() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if(image!=null)
    _upLoadImage(image);
  }

  //上传图片
  _upLoadImage(File image) async {
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
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = new FormData.from({
      "name":Provide.value<MemberProvider>(context).loginInfo.data.name,
      "userId": Provide.value<MemberProvider>(context).userInfo.userId,
      "uploadFile": new UploadFileInfo(new File(path), name)
    });
    Dio dio = new Dio();
    var respone = await dio.post<String>("http://192.168.2.153:8080//HttpServletTest/upLoadPic", data: formData);
    if (respone.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "头像上传成功",
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey);
      print(respone.data.toString());
      MemberLoginInfo longinInfo = Provide.value<MemberProvider>(context).loginInfo;
      longinInfo.data.picUrl = respone.data.toString().trim();
      Provide.value<MemberProvider>(context).setLoginInfo(longinInfo);
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(
          msg: "头像上传失败",
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey);
      Navigator.pop(context);
    }
  }

}
