import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:second_hand_trading_app/viewmodel/user_view_model.dart';

typedef Success = void Function(dynamic json);
typedef Fail = void Function(String reason, int code);
typedef After = void Function();

class Http {
  static Dio _dio;
  static Http https = Http();
  static String baseUri = "http://10.0.2.2:8080";
  static String baseImgUri = "http://10.0.2.2:8080/img/";
  static Http getInstance() {
    return https;
  }

  Http() {
    if (_dio == null) {
      _dio = createDio();
    }
  }

  Dio createDio() {
    var dio = Dio(BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      sendTimeout: 30000,
      baseUrl: baseUri,
      responseType: ResponseType.json,
    ));
    dio.interceptors.add(DioLogInterceptor());

    return dio;
  }

  Future<void> get(String uri, Map<String, dynamic> params,
      {Success success, Fail fail, After after}) {
    try {
      _dio.get(uri, queryParameters: params).then((response) {
      if (response.statusCode == 200) {
        if (success != null) {
          success(response.data);
        }
      } else {
        if (fail != null) {
          fail(response.statusMessage, response.statusCode);
        }
      }

      if (after != null) {
        after();
      }
    });
    } catch (e) {
      if (fail != null) {
          fail("没有网络", -1);
        }
    }
    return Future.value();
  }

  Future<void> post(String uri, dynamic data,
      {Success success, Fail fail, After after}) {
        if(UserViewModel.userBean?.data?.token !=null){
          _dio.options.headers["X-token"] = UserViewModel.userBean?.data?.token;
        }
    try{
      _dio.post(uri, data: data).then((response) {
      if (response.statusCode == 200) {
        if (success != null) {
          success(response.data);
        }
      } else {
        if (fail != null) {
          fail(response.statusMessage, response.statusCode);
        }
      }

      if (after != null) {
        after();
      }
    });
    }catch(e){
      if(fail!=null){
        fail("没有网络",-1);
      }
    }
    return Future.value();
  }


}
