import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:second_hand_trading_app/model/goods_detail.dart';
import 'package:second_hand_trading_app/model/noaml_response.dart';
import 'package:second_hand_trading_app/model/up_load_model.dart';
import 'package:second_hand_trading_app/utils/http/http_utils.dart';

typedef Success = void Function(dynamic json);
typedef Fail = void Function(String reason, int code);
typedef After = void Function();

class GoodsApi {
  static var _http = Http.getInstance();

  static Future<void> addNewGoods(
      List<String> imgs, Map<String, dynamic> detail,
      {Success success, Fail fail}) async {
    String uploadPath = "/file/upload/img/goods";

    ///通过FormData
    FormData formData = FormData();
    for (String path in imgs) {
      var multipartFile = await MultipartFile.fromFile(path);
      formData.files.add(MapEntry("files", multipartFile));
    }
    await _http.post(uploadPath, formData, success: (data) async {
      var upLoadModel = UpLoadModel.fromJson(data);
      if (upLoadModel.code == 200) {
        List<Map<String, String>> l = List();
        upLoadModel.data.forEach((element) {
          l.add({"image": element});
        });
        Map temp = {"goods": detail, "imgs": l};
        _http.post("/api/goods/addNewGoods", temp, success: (json) {
          if (success != null) {
            success(data);
          }
        }, fail: fail);
      }
    });
    return Future.value();
  }

  static void search(String text,
      {Map<String, dynamic> orderby,
      int page = 1,
      Success success,
      Fail fail}) {
    if (text == null) {
      fail("Can not handle empty search", -1);
      return;
    }
    Map<String, dynamic> map = {'text': text, 'page': page};
    if (orderby != null) {
      map.addAll(orderby);
    }
    _http.post("/api/goods/search", map, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) {
          success(res.data);
        }
      } else {
        if (fail != null) {
          fail(res.message, res.code);
        }
      }
    }, fail: (data, code) {});
  }

  static void getGoodsInfo(goods_id, {Success success, Fail fail}) {
    _http.post("/api/goods/info", goods_id, success: (data) {
      log(data.toString());
      var goodsDetail = GoodsDetail.fromJson(data);
      log(goodsDetail.message);
      if (goodsDetail.code == 200) {
        if (success != null) {
          success(goodsDetail);
        }
      } else {
        if (fail != null) {
          fail(goodsDetail.message, goodsDetail.code);
        }
      }
    }, fail: (message, code) {});
  }

  static void getGoodsByPage(int currPage, int i,
      {Success success, Fail fail}) {
    _http.get(
      "/api/goods/getGoodsByPage/${currPage}/${i}",
      null,
      success: (json) {
        var res = NomalResponse.fromJson(json);
        log(res.message);
        if (res.code == 200) {
          if (success != null) {
            success(res.data);
          }
        } else {
          if (fail != null) {
            fail(res.message, res.code);
          }
        }
      },
    );
  }

  static void getOrderInfo(orderId, {Success success}) {
    _http.get("/api/goods/orderInfo/${orderId}", null, success: (json) {
      var res = NomalResponse.fromJson(json);
      if (res.code == 200) {
        if (success != null) {
          success(res.data);
        }
      }
    });
  }

  static void createOrder(Map data, {Success success}) {
    _http.post("/api/goods/createOrder", data, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) {
          success(res.data);
        }
      }
    });
  }

  static void payOrder(orderId, {Success success, Fail fail}) {
    _http.post("/api/goods/payOrder", orderId, success: (data) {
      var res = NomalResponse.fromJson(data);
      if (res.code == 200) {
        if (success != null) {
          success(res.message);
        }
      } else {
        if (fail != null) {
          fail(res.message, res.code);
        }
      }
    });
  }

  static void getOrders(int page, int count, {Success success}) {
    _http.get("/api/goods/getOrderByPage/${page}/${count}", null,
        success: (data) {
      var res = NomalResponse.fromJson(data);
      log(res.message);
      if (res.code == 200) {
        if (success != null) {
          success(res.data);
        }
      }
    });
  }

  static void getPayingOrders(int page, int count, {Success success}) {
    _http.get("/api/goods/getPayingOrderByPage/${page}/${count}", null,
        success: (data) {
      var res = NomalResponse.fromJson(data);
      log(res.message);
      if (res.code == 200) {
        if (success != null) {
          success(res.data);
        }
      }
    });
  }

  static void getReturnOrders(int page, int count, {Success success}) {
    _http.get("/api/goods/getReturnOrderByPage/${page}/${count}", null,
        success: (data) {
      var res = NomalResponse.fromJson(data);
      log(res.message);
      if (res.code == 200) {
        if (success != null) {
          success(res.data);
        }
      }
    });
  }

  static void getReceivingOrders(int page, int count, {Success success}) {
    _http.get("/api/goods/getReceivingOrderByPage/${page}/${count}", null,
        success: (data) {
      var res = NomalResponse.fromJson(data);
      log(res.message);
      if (res.code == 200) {
        if (success != null) {
          success(res.data);
        }
      }
    });
  }

  static void getLabels({Success success}) {
    _http.get("/api/goods/getLabels", null,
    success: (json){
      var res = NomalResponse.fromJson(json);
      if(res.code == 200){
        if(success!=null){
          success(res.data);
        }
      }
    });
  }

  static void addNewLabel(String name, String info, {Success success}) {
    Map data = {
      "name":name,
      "info":info
    };
    _http.post("/api/goods/addLabel", data,success: (json){
      var res = NomalResponse.fromJson(json);
      if(res.code == 200){
        if(success!=null){
          success(res.data);
        }
      }
    });
  }

  static void getSales(int page,int count,{Success success}) {
    _http.get("/api/goods/getSaleGoodsByPage/${page}/${count}", null,success: (json){
      var res = NomalResponse.fromJson(json);
      if(res.code == 200){
        if(success!=null){
          success(res.data);
        }
      }
    });
  }

  static void getCommentsByPage(int goodsId,int page, int count, {Success success, Fail fail}) {
      _http.get("/api/goods/getCommentsByPage/${goodsId}/${page}/${count}",null,success: (json){
        var res = NomalResponse.fromJson(json);
        if(res.code == 200){
          if(success!=null){
            success(res.data);
          }
        }
      },fail: (reason, code) {
        
      },);
  }

  static void postComment(int goodsId, String content, {Success success, Fail fail}){
    _http.post("/api/goods/postComment", {
      "goodsId":goodsId,
      "content" : content
    },
      success: (json){
        var res =NomalResponse.fromJson(json);
        if(res.code == 200){
          if(success!=null){
            success(res.data);
          }
        }
      }
    );
  }

  static void getRecommend({Success success, Fail fail}) {
    _http.get("/api/goods/getRecommend",null,success: (json) {
        var res = NomalResponse.fromJson(json);
        log(res.message);
        if (res.code == 200) {
          if (success != null) {
            success(res.data);
          }
        } else {
          if (fail != null) {
            fail(res.message, res.code);
          }
        }
      },);
  }
  
}
