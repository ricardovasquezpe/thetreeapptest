import 'dart:io';
import 'package:dio/dio.dart';
import 'package:thetreeapptest/app/utils/constants.dart';

class Network{
  Dio dio = new Dio();
  static final HEADERS = {
    HttpHeaders.contentTypeHeader: "application/json"
  };

  Network(){
    BaseOptions options = new BaseOptions(
      baseUrl: URL_BASE_API,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = new Dio(options);
  }
}