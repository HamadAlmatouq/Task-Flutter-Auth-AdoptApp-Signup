import 'package:dio/dio.dart';

class Client {
  static final _baseURL = "https://coded-pets-api-auth.eapi.joincoded.com";
  static final Dio dio = Dio(BaseOptions(baseUrl: _baseURL));
}
