import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/instance_manager.dart';

class ApplicationBinding implements Bindings{

  Dio _dio() {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
    // dio.options.headers['refreshtoken'] = 'false';
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler) async{
          print('interceptors onrequest uri ${options.uri}');
          print('interceptors onrequest data ${options.data}');
          print('interceptors onrequest Authorization ${options.headers['Authorization']}');


          options.contentType ??=  'application/x-www-form-urlencoded';
          return handler.next(options); //continue
        },
        onResponse:(response,handler) {
          print('interceptors dio_response $response');
          return handler.next(response); // continue

        },
        onError: (DioError error, handler) async {
          print('interceptors dio_error response ${error}');
        }));

    return dio;
  }

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(_dio,fenix: true);
  }

}