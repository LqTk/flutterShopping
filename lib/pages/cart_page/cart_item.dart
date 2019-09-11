import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping/model/cartInfo.dart';
import 'cart_count.dart';
import 'package:provide/provide.dart';
import 'package:shopping/provide/cart.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;
  final int index;

  CartItem(this.item,this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, (index==0)?5.0:0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.black12
          ),
          top: (index==0)?BorderSide(width: 1,color: Colors.black12):BorderSide(width: 0,color: Colors.transparent)
        )
      ),
      child: Row(
        children: <Widget>[
          _cartCheckButton(context),
          _cartImage(),
          _cartGoodsName(),
          _cartPrice(context)
        ],
      ),
    );
  }

  //复选框按钮
  Widget _cartCheckButton(context){
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val){
          item.isCheck = val;
          Provide.value<CartProvide>(context).changeCheckState(item);
        },
      ),
    );
  }

  Widget _cartImage(){
    return Container(
      width: ScreenUtil().setWidth(150),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color:Colors.black12,width: 1)
      ),
      child: Image.network(item.images),
    );
  }

  Widget _cartGoodsName(){
    return Container(
      width: ScreenUtil().setWidth(290),
      padding: EdgeInsets.all(3.0),
      margin: EdgeInsets.only(left: 5.0),
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child:
            Text(
              item.goodsName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: CartCount(item),
          ),
        ],
      ),
    );
  }

  Widget _cartPrice(context){
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Text(
            '￥${item.presentPrice}',
            style: TextStyle(
              color: Colors.black26,
              fontSize: ScreenUtil().setSp(25),
              decoration: TextDecoration.lineThrough
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: InkWell(
              onTap: (){
                Provide.value<CartProvide>(context).deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
