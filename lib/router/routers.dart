import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routers{
  static String root = '/';
  static String detailsPage = '/detail';
  static void configreRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        print('ERROR====>>>>没有发现该页面==${params['id'].first}');
        return null;
      }
    );
    router.define(detailsPage, handler: detailsHandler);
  }
}