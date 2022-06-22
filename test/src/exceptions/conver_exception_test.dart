import 'package:http_service1/http_service1.dart';
import 'package:test/test.dart';

void main() {
  final convertExc = ConvertExc();

  test('is a type exception', () {
    expect(convertExc, isA<ConvertExc>());
    expect(convertExc, isA<Exception>());
  });

  test('default massage', () {
    expect(convertExc.message, null);
    expect(convertExc.toString(), 'Convert Exception');
  });

  test('custom massage', () {
    final convertExc1 = ConvertExc(message: 'error');
    expect(convertExc1.message, 'error');
    expect(convertExc1.toString(), 'error');
  });
}
