abstract class ApiServices {
  Future<T> post<T>(ApiPostParams params);
  Future<T> get<T>(ApiGetParams params);
  Future<T> put<T>(ApiPutParams params);
}

class ApiPostParams {
  final String url;
  final String? token;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? queryParameters;

  ApiPostParams({
    required this.url,
    required this.data,
    required this.token,
    required this.queryParameters,
  });
}
class ApiGetParams {}

class ApiPutParams {}

