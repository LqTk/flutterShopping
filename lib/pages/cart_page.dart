import 'package:flutter/material.dart';
import '../provide/counter.dart';
import 'package:provide/provide.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: <Widget>[
              Number(),
              MyButton()
            ],
          ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<Counter>(
        builder: (context,child,counter){
          return Text('${counter.count}');
        },
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(onPressed: ()=>Provide.value<Counter>(context).increment(),
      child: Text('递增'),),
    );
  }
}


