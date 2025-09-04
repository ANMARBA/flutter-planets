// This class is to capture the server events  that return Exception
class ServerException implements Exception {
  final String message;

  ServerException({required this.message}) : super();
}

class ConnectionException implements Exception {
  final String message;

  ConnectionException({required this.message}) : super();
}

class HttpException implements Exception {
  final String message;

  HttpException({required this.message}) : super();
}
