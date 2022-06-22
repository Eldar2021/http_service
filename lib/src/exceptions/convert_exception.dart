/// Convert Exception
/// Exception to indicate that the requested conversion cannot be performed.
class ConvertExc implements Exception {
  ConvertExc({this.message});

  final String? message;

  @override
  String toString() {
    return message ?? 'Convert Exception';
  }
}
