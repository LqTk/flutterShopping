const serviceUrl = 'https://wxmini.baixingliangfan.cn/';
const servicePath = {
  'homePageContent':serviceUrl+'baixing/wxmini/homePageContent',//商店首页信息
  'homePageBelowConten':serviceUrl+'baixing/wxmini/homePageBelowConten',//商城首页热卖商品
  'getCategory':serviceUrl+'baixing/wxmini/getCategory',//商品分类
  'getMallGoods':serviceUrl+'baixing/wxmini/getMallGoods',//商品分类的商品列表
  'getGoodDetailById':serviceUrl+'baixing/wxmini/getGoodDetailById',//商品详细信息
};

const myServiceUrl = 'http://192.168.2.153:8080/HttpServletTest/';
const myServicePath = {
  'loginPath':myServiceUrl+'Login',
  'registerPath':myServiceUrl+'Register',
  'headUrlPath':myServiceUrl+'ImageById?',
  'upLoadPicPath':myServiceUrl+'upLoadPic',
  'changeNamePath':myServiceUrl+'ChangeName',
};