import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:shopping/pages/home_page.dart';
import './router_handler.dart';

class Routers{
  static String root = '/';
  static String detailsPage = '/detail';
  static String loginPage = '/login';
  static String settingPage = '/setting';
  static String registerPage = '/register';
  static void configreRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        print('ERROR====>>>>没有发现该页面==${params['id'].first}');
        return HomePage();
      }
    );
    router.define(detailsPage, handler: detailsHandler);
    router.define(loginPage, handler: loginHandler);
    router.define(settingPage, handler: settingHandler);
    router.define(registerPage, handler: registerHandler);
  }
}