import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/services/api/api_services.dart';

class DioServices implements ApiServices {
  final _dio = Dio();
  @override
  Future<Response> post<Response>(ApiPostParams params) async {
    final response = await _dio.post(
      params.url,
      data: params.data,
      queryParameters: params.queryParameters,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {kAuthorization: "$kBearer ${params.token}"},
      ),
    );
    return response.data;
  }

  @override
  Future<T> get<T>(ApiGetParams params) async {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<T> put<T>(ApiPutParams params) async {
    // TODO: implement put
    throw UnimplementedError();
  }
}
