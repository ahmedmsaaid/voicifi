

import '../api/end_points.dart';

class ErrorModel{
  final int status;
  final String msg;

  ErrorModel({required this.status, required this.msg});
  factory ErrorModel.fromJson(Map<String,dynamic>jsonData){
    return ErrorModel(status:jsonData[ApiKey.status], msg:jsonData[ApiKey.errorMessage]);

  }
}