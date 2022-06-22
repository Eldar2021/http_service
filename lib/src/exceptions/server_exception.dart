/// Server Exception
class ServerException implements Exception {
  ServerException({this.massage});

  final String? massage;

  @override
  String toString() {
    return massage ?? 'Server Exception';
  }
}
