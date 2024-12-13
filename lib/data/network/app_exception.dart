class AppException implements Exception {
  final _prefix;
  final _message;

  AppException([this._message,this._prefix]);

  @override
  String toString() {
    // TODO: implement toString
    return '$_prefix : $_message';
  }
}

// Fetch data exception
class FetchDataException extends AppException {
  FetchDataException(message): super('Error during communication',message);
}

