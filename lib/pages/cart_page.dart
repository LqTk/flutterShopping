import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shopping/model/cartInfo.dart';
import 'package:shopping/provide/cart.dart';
import 'package:shopping/pages/cart_page/cart_item.dart';
import 'package:shopping/pages/cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context,snapshot){
          List<CartInfoModel> cartList = Provide.value<CartProvide>(context).cartList;
          if(snapshot.hasData){
            return Stack(
              children: <Widget>[
                Provide<CartProvide>(
                  builder: (context,child,val){
                    cartList = Provide.value<CartProvide>(context).cartList;
                    return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return CartItem(cartList[index],index);
                      },
                    );
                    },
                  ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom()
                )
              ],
            );
          }else{
            return Center(
              child: Text('加载中.....'),
            );
          }
        }
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async{
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}




