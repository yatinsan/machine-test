import 'package:dio/dio.dart';
import 'package:meetings/config/messages.dart';

apiErrorHandler(dynamic error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "connection timeout";

      case DioExceptionType.sendTimeout:
        return "send timeout";

      case DioExceptionType.receiveTimeout:
        return "receive timeout";

      case DioExceptionType.badCertificate:
        return "bad certificate";

      case DioExceptionType.badResponse:
        return "bad response";

      case DioExceptionType.connectionError:
        return "Network Error";


      case DioExceptionType.unknown:
        return Messages.somethingWentWrong;

      default:
        return Messages.somethingWentWrong;
    }
  }

  return Messages.somethingWentWrong;
}
