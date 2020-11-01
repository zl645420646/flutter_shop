class CategoryMallGoodListModel {
  String code;
  String message;
  List<CategoryListGoods> data;

  CategoryMallGoodListModel({this.code, this.message, this.data});

  CategoryMallGoodListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CategoryListGoods>();
      json['data'].forEach((v) {
        data.add(new CategoryListGoods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryListGoods {
  String image;
  String oriPrice;
  String presentPrice;
  String goodsName;
  String goodsId;

  CategoryListGoods(
      {this.image,
      this.oriPrice,
      this.presentPrice,
      this.goodsName,
      this.goodsId});

  CategoryListGoods.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    oriPrice = json['oriPrice'].toString();
    presentPrice = json['presentPrice'].toString();
    goodsName = json['goodsName'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    return data;
  }
}
