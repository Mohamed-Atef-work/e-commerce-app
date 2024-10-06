abstract class LocalDataBaseService {
  Future save<T>(String key, T value);
  Future<T?> read<T>(String key);
  Future delete(String key);
}
