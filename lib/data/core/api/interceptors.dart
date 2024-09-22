import 'package:dio/dio.dart';

import '../../cache/cache_helper.dart';
import 'end_points.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {
      "authorization": "e99df26a7b5e4a34a48ee5d70e1b6ab5",
      'Content-Type': SharedHelper.getData(ApiKey.type) ?? 'application/json',
      // استخدام قيمة افتراضية إذا كانت النتيجة null
    };

    super.onRequest(options, handler);
  }
}
