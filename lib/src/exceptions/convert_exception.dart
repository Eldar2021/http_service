class ConvertExc implements Exception {
  ConvertExc({this.massage});

  final String? massage;

  @override
  String toString() {
    return massage ?? 'Convert Exception';
  }
}
