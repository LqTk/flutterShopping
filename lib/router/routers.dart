import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:shopping/pages/home_page.dart';
import './router_handler.dart';

class Routers{
  static String root = '/';
  static String detailsPage = '/detail';
  static void configreRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        print('ERROR====>>>>没有发现该页面==${params['id'].first}');
        return HomePage();
      }
    );
    router.define(detailsPage, handler: detailsHandler);
  }
}