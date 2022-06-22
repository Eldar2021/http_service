import 'package:http_service1/http_service1.dart';
import 'package:test/test.dart';

void main() {
  final authExc = AuthenticationException();

  test('is a type exception', () {
    expect(authExc, isA<AuthenticationException>());
    expect(authExc, isA<Exception>());
  });

  test('default massage', () {
    expect(authExc.message, null);
    expect(authExc.toString(), 'Auhtentication Exception');
  });

  test('custom massage', () {
    final authExc1 = AuthenticationException(message: 'error');
    expect(authExc1.message, 'error');
    expect(authExc1.toString(), 'error');
  });
}
