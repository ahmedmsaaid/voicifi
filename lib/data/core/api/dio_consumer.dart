
import 'package:dio/dio.dart';

import '../errors/exeption.dart';
import 'api_consumer.dart';
import 'end_points.dart';
import 'interceptors.dart';


class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}){
    dio.options.baseUrl=EndPoints.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,

    ));

  }

  @override
  Future delete(
      String path, {Map<String, dynamic>? queryParameters,
      dynamic  data,
      bool isFormData = false})
  async {
    try {

      final response =
          await dio.delete(path, queryParameters: queryParameters,
              data:isFormData?FormData.fromMap(data):data
              );
      return response.data;
    } on DioException catch (e) {
      handelDioExceptions(e);
    }
  }



  @override
  Future get(
      {required String path, Map<String, dynamic>? queryParameters, Object?
      data})
  async {
    try{
      final response=await dio.get(path,queryParameters: queryParameters,
          data: data);
          return response.data;

    }on DioException catch(e){
      handelDioExceptions(e);
    }

   }

  @override
  Future patch(String path, {Map<String, dynamic>? queryParameters,
    dynamic  data,
    bool isFormData = false}) async {
    try {
      final response =await dio.patch(path,queryParameters: queryParameters, data:isFormData?FormData.fromMap(data):data);
      return response.data;
    } on DioException catch (e) {
handelDioExceptions(e) ;   }


  }

  @override
  Future post(String path, {Map<String, dynamic>? queryParameters,
    dynamic  data,
    bool isFormData = false}) async {
  try{
    final response =await dio.post(path, data:isFormData?FormData.fromMap(data):data,queryParameters:
    queryParameters);
    return response.data;
  } on DioException catch(e){
    handelDioExceptions(e);
  }


  }
}
