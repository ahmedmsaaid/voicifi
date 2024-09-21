import 'package:dio/dio.dart';

import 'error_model.dart';

class ServerErrors implements Exception {
  final ErrorModel errorModel;

  ServerErrors({required this.errorModel});
}

void handelDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerErrors(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerErrors(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerErrors(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerErrors(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerErrors(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerErrors(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerErrors(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw ServerErrors(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 401:
          throw ServerErrors(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 403:
          throw ServerErrors(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 404:
          throw ServerErrors(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 409:
          throw ServerErrors(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 422:
          throw ServerErrors(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 504:
          throw ServerErrors(
              errorModel: ErrorModel.fromJson(e.response!.data));
      }
  }
}