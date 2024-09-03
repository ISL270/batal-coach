/// Parent exception class that can only be inherited and not instantiated.
sealed class GenericException implements Exception {
  final String code;
  final String message;

  const GenericException({
    required this.code,
    required this.message,
  });
}

/// Business Exception.
class BusinessException extends GenericException {
  // here you can extend attributes and methods as needed.
  const BusinessException({
    required super.code,
    required super.message,
  });
}

/// Exception caused by network related issues.
class NetworkException extends GenericException {
  // here you can extend attributes and methods as needed.
  final NetworkExceptionType type;

  const NetworkException({
    required super.code,
    required super.message,
    this.type = NetworkExceptionType.unKnown,
  });
}

/// HTTP exceptions with status codes.
enum NetworkExceptionType {
  badRequest(400),
  unAuthorized(401),
  notFound(404),
  serverError(500),
  timeout(599),
  unKnown(0);

  final int httpStatusCode;
  const NetworkExceptionType(this.httpStatusCode);
}
