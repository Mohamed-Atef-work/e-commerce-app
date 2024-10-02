import 'dio_services.dart';

abstract class ApiServices<T> {
  Future<T> post(ApiPostParams params);
  Future<T> get(ApiGetParams params);
  Future<T> put(ApiPutParams params);
}

