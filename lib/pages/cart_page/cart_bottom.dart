import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopping/provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0),
      color: Colors.white,
      child: Provide<CartProvide>(
        builder: (context,child,childCategory){
          return Row(
            children: <Widget>[
              selectAllBtn(context),
              _bottomCenter(context),
              _cartPay(context),
            ],
          );
        },
      )
    );
  }

  Widget selectAllBtn(context){
    bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).changeAllCheckBtnState(!isAllCheck);
      },
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val){
              Provide.value<CartProvide>(context).changeAllCheckBtnState(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  Widget _bottomCenter(context){
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      alignment: Alignment.centerRight,
      width: ScreenUtil().setWidth(350),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '合计：',
                  style: TextStyle(fontSize: ScreenUtil().setSp(34)),
                )
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(200),
                child: Text(
                  '￥${allPrice}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(34),
                    color: Colors.red
                  ),
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            width: ScreenUtil().setWidth(350),
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(23),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cartPay(context){
    int allCount = Provide.value<CartProvide>(context).alChecklGoodsCount;
    return Container(
      padding: EdgeInsets.fromLTRB(5.0,5.0,2.0,5.0),
      width: ScreenUtil().setWidth(190),
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0)
          ),
          child: Text(
            '结算(${allCount})',
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(32)
            ),
          ),
        )
      ),
    );
  }
}
