class EndPoints {
  static String baseUrl = 'https://api.assemblyai.com/v2/';
  static String upLoad = 'upload';
  static String transcript = 'transcript';
  static String openApi = 'https://api.openai.com/v1/completions';

  // static String update = 'user/update';

  static String getId(id) {
    return "transcript/$id";
  }
}

class ApiKey {
  static String status = 'status';
  static String errorMessage = 'ErrorMessage';
  static String name = 'name';
  static String email = 'email';
  static String password = 'password';
  static String confirmPassword = 'confirmPassword';
  static String token = 'token';
  static String message = 'message';
  static String id = 'id';
  static String phone = 'phone';
  static String location = 'location';
  static String profilePic = 'profilePic';
  static String favorites = 'favorites';
  static String createdAt = 'createdAt';
  static String type = 'content-type';
}
