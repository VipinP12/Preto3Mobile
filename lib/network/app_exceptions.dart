class AppExceptions implements Exception {
  final String? message;
  final String? prefix;
  final int? errorCode;

  AppExceptions([this.message, this.prefix, this.errorCode]);
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message, int? errorCode])
      : super(message, 'Error Request', errorCode) {
    print("BAD REQUEST MESSAGE:$message");
  }
}

class ExpectationFailed extends AppExceptions {
  ExpectationFailed([String? message, int? errorCode])
      : super(message, 'Expectation Failed', errorCode) {
    print("Expectation Failed:$message");
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message, int? errorCode])
      : super(message, 'Unable to process', errorCode);
}

class ApiNotRespondingException extends AppExceptions {
  ApiNotRespondingException([String? message, int? errorCode])
      : super(message, 'Server not responding', errorCode);
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String? message, int? errorCode])
      : super(message, 'UnAuthorized request', errorCode);
}

class ForbiddenException extends AppExceptions {
  ForbiddenException([String? message, int? errorCode])
      : super(message, 'Forbidden request', errorCode);
}

class OlderAppVersionException extends AppExceptions {
  OlderAppVersionException([message, int? errorCode])
      : super(message, "Older App Version", errorCode);
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([message, int? errorCode])
      : super(message, "Invalid Input. ", errorCode);
}

class NotFoundException extends AppExceptions {
  NotFoundException([message, int? errorCode])
      : super(message, "Not Found. ", errorCode);
}

class InternalServerException extends AppExceptions {
  InternalServerException([message, int? errorCode])
      : super(message, "Internal Server Error. ", errorCode);
}
