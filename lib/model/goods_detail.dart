class GoodsDetail {
  String message;
  int code;
  Data data;

  GoodsDetail({this.message, this.code, this.data});

  GoodsDetail.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Images> images;
  GoodsInfo goodsInfo;

  Data({this.images, this.goodsInfo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    goodsInfo = json['goodsInfo'] != null
        ? new GoodsInfo.fromJson(json['goodsInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.goodsInfo != null) {
      data['goodsInfo'] = this.goodsInfo.toJson();
    }
    return data;
  }
}

class Images {
  int id;
  int goodsId;
  String image;

  Images({this.id, this.goodsId, this.image});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goodsId = json['goodsId'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['goodsId'] = this.goodsId;
    data['image'] = this.image;
    return data;
  }
}

class GoodsInfo {
  int id;
  String name;
  String info;
  int price;
  String ownerId;
  int originalPrice;
  String defaultImage;
  int count;
  int newPercentage;
  String createdAt;

  GoodsInfo(
      {this.id,
      this.name,
      this.info,
      this.price,
      this.ownerId,
      this.originalPrice,
      this.defaultImage,
      this.count,
      this.newPercentage,
      this.createdAt});

  GoodsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    info = json['info'];
    price = json['price'];
    ownerId = json['ownerId'];
    originalPrice = json['originalPrice'];
    defaultImage = json['defaultImage'];
    count = json['count'];
    newPercentage = json['newPercentage'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['info'] = this.info;
    data['price'] = this.price;
    data['ownerId'] = this.ownerId;
    data['originalPrice'] = this.originalPrice;
    data['defaultImage'] = this.defaultImage;
    data['count'] = this.count;
    data['newPercentage'] = this.newPercentage;
    data['createdAt'] = this.createdAt;
    return data;
  }
}