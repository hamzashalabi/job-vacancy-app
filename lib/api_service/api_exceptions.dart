// response status aside from 200
class ResponseExcpetion implements Exception {
  @override
  String toString() {
    return 'Server returned an invalid response. Please try again.';
  }
}

// dio exceptions
class DioConnectionTimeOutException implements Exception {
  @override
  String toString() {
    return 'Connection timed out. Please check your internet connection and try again.';
  }
}

class DioReceiveTimeOutException implements Exception {
  @override
  String toString() {
    return 'Receive timeout. The server took too long to respond.';
  }
}

// generic exceptions
class GenericException implements Exception {
  @override
  String toString() {
    return 'An unexpected error occurred. Please try again later.';
  }
}
