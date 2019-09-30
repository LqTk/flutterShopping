import 'package:flutter/material.dart';
import 'package:shopping/provide/member.dart';
import './pages/index_page.dart';
import './provide/counter.dart';
import 'package:provide/provide.dart';
import './provide/child_category.dart';
import './provide/child_category_goods_list.dart';
import 'package:fluro/fluro.dart';
import 'router/application.dart';
import 'router/routers.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
import './provide/currentIndex.dart';

void main(){
  var providers = Providers();

  providers
  ..provide(Provider<Counter>.value(Counter()))
  ..provide(Provider<ChildCategory>.value(ChildCategory()))
  ..provide(Provider<CategoryGoodsListProvide>.value(CategoryGoodsListProvide()))
  ..provide(Provider<CartProvide>.value(CartProvide()))
  ..provide(Provider<CurrentIndexProvide>.value(CurrentIndexProvide()))
  ..provide(Provider<MemberProvider>.value(MemberProvider()))
  ..provide(Provider<DetailsInfoProvide>.value(DetailsInfoProvide()));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routers.configreRoutes(router);
    Application.router = router;
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}
