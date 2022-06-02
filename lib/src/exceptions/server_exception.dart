class ServerExc implements Exception {
  ServerExc({this.massage});

  final String? massage;

  @override
  String toString() {
    return massage ?? 'Server Exception';
  }
}
