// Convert Exception
// Exception to indicate that the requested conversion cannot be performed.
class ConvertExc implements Exception {
  ConvertExc({this.massage});

  final String? massage;

  @override
  String toString() {
    return massage ?? 'Convert Exception';
  }
}
