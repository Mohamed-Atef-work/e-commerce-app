class ServerException implements Exception {
  final String message;
  const ServerException({
    required this.message,
  });
}

class LocalDataBaseException implements Exception {
  final String message;
  const LocalDataBaseException({
    required this.message,
  });
}
