import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:meetings/config/constent.dart';

class CustomInterceptor extends InterceptorsWrapper {
  @override
  onRequest(options, handler) async {
    options.headers["Authorization"] = 'Bearer $sampleToken';
    options.headers["Accept"] = "application/json";
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(response.data.toString());
    super.onResponse(response, handler);
  }
}
