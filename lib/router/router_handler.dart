import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../pages/details_page.dart';
import '../provide/details_info.dart';
import 'package:provide/provide.dart';

Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    String goodsId = params['id'].first;
    print('goodsId=========${goodsId}');
    Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('left');
    return DetailPage(goodsId);
  }
);
