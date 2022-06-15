// Auhtentication Exception
class AuthExc implements Exception {
  AuthExc({this.massage});

  final String? massage;

  @override
  String toString() {
    return massage ?? 'Auhtentication Exception';
  }
}
