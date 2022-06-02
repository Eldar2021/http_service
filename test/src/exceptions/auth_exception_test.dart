import 'package:http_service1/http_service1.dart';
import 'package:test/test.dart';

void main() {
  final authExc = AuthExc();

  test('is a type exception', () {
    expect(authExc, isA<AuthExc>());
    expect(authExc, isA<Exception>());
  });

  test('default massage', () {
    expect(authExc.massage, null);
    expect(authExc.toString(), 'Auhtentication Exception');
  });

  test('custom massage', () {
    final authExc1 = AuthExc(massage: 'error');
    expect(authExc1.massage, 'error');
    expect(authExc1.toString(), 'error');
  });
}
