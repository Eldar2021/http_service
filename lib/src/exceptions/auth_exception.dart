/// Auhtentication Exception
class AuthenticationException implements Exception {
  AuthenticationException({this.message});

  final String? message;

  @override
  String toString() {
    return message ?? 'Auhtentication Exception';
  }
}
