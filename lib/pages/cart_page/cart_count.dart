import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping/model/cartInfo.dart';
import 'package:provide/provide.dart';
import 'package:shopping/provide/cart.dart';

class CartCount extends StatelessWidget {

  final CartInfoModel item;

  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(170),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _cartReduce(context),
          _cartNum(),
          _cartAdd(context)
        ],
      ),
    );
  }

  Widget _cartReduce(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).changeGoodsCount(item.goodsId, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (item.count==1)?Colors.black12:Colors.white,
          border: Border(
            right: BorderSide(width: 1,color: Colors.black12)
          )
        ),
        child: Text((item.count==1)?'':'-'),
      ),
    );
  }

  Widget _cartAdd(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).changeGoodsCount(item.goodsId, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1,color: Colors.black12)
          )
        ),
        child: Text('+'),
      ),
    );
  }

  Widget _cartNum(){
    return Container(
      width: ScreenUtil().setWidth(75),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}
