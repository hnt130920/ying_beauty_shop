import 'package:dio/dio.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class ApiInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (AppVariable.userInfo != null) {
      options.headers['Authorization'] =
          'Bearer ${AppVariable.userInfo!.token}';
    }
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }
}
