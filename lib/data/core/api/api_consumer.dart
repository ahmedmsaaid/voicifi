abstract class ApiConsumer {
  Future<dynamic> get({
    required String path,
    Object data,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> post(String path,
      {Map<String, dynamic>? queryParameters,
      dynamic data,
      bool isFormData = false});

  Future<dynamic> patch(String path,
      {Map<String, dynamic>? queryParameters,
      dynamic data,
      bool isFormData = false});

  Future<dynamic> delete(String path,
      {Map<String, dynamic>? queryParameters,
      dynamic data,
      bool isFormData = false});
}
