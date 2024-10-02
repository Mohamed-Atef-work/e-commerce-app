import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/services/api/api_services.dart';

class DioServices implements ApiServices<Response> {
  final _dio = Dio();
  @override
  Future<Response> post(ApiPostParams params) async {
    final response = await _dio.post(
      params.url,
      data: params.data,
      options: Options(
        headers: params.headers,
        contentType: params.contentType,
      ),
    );
    return response;
  }

  @override
  Future<Response> get(ApiGetParams params) async {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Response> put(ApiPutParams params) async {
    // TODO: implement put
    throw UnimplementedError();
  }
}

class ApiPostParams {
  final String url;
  final String? contentType;

  final Map<String, dynamic> data;
  final Map<String, dynamic> headers;
  final Map<String, dynamic>? queryParameters;

  ApiPostParams({
    this.contentType,
    required this.url,
    required this.data,
    this.queryParameters,
    required this.headers,
  });
}

class ApiGetParams {}

class ApiPutParams {}
