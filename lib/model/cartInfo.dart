class CartInfoModel {
  String goodsId;
  String goodsName;
  int count;
  double price;
  double presentPrice;
  String images;
  bool isCheck;

  CartInfoModel(
      {this.goodsId, this.goodsName, this.count, this.price, this.presentPrice, this.images, this.isCheck});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    presentPrice = json['presentPrice'];
    images = json['images'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['presentPrice'] = this.presentPrice;
    data['images'] = this.images;
    data['isCheck'] = this.isCheck;
    return data;
  }
}
