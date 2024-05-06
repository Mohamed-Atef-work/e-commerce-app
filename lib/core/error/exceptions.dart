class ServerException implements Exception {
  final String message;
  final dynamic object;
  const ServerException({
    required this.message,
    this.object,
  });
}

class LocalDataBaseException implements Exception {
  final String message;
  const LocalDataBaseException({
    required this.message,
  });
}
