import 'package:dio/dio.dart';
import 'package:meetings/utils/interseptor.dart';

Dio dio = Dio(BaseOptions())..interceptors.add(CustomInterceptor());
