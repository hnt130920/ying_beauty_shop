import 'package:dio/dio.dart';
import 'package:ying_beauty/api/api.dart';
import 'package:ying_beauty/api/api_interceptor.dart';
import 'package:ying_beauty/model/login_info.dart';
import 'package:ying_beauty/model/order.dart';
import 'package:ying_beauty/model/receiver_info.dart';

class AppVariable {
  static LoginInfo? userInfo;
  static late ApiClient api;
  static int reId = 0;
  static ReceiverInfo? receiver;
  static Order? order;

  static void init() {
    final dio = Dio();
    dio.options.contentType = 'application/json;charset=uf-8';
    dio.interceptors.add(ApiInterceptor());
    api = ApiClient(dio);
  }
}
