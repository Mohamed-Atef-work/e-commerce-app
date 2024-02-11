abstract class LocalDataBaseService {
  Future save<T>(String key, T value);
  Future<R?> read<R>(String key);
  Future delete(String key);
}
