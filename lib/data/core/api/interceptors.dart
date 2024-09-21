import 'package:dio/dio.dart';
import 'package:happy_tick/core/api/end_points.dart';

import '../../cache/local/cache_helper.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKey.token] = SharedHelper.getData(ApiKey.token) != null
        ? 'FOODAPI ${SharedHelper.getData(ApiKey.token)}'
        : null;

    super.onRequest(options, handler);
  }
}
