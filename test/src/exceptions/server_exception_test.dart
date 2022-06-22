import 'package:http_service1/http_service1.dart';
import 'package:test/test.dart';

void main() {
  final servertExc = ServerException();

  test('is a type exception', () {
    expect(servertExc, isA<ServerException>());
    expect(servertExc, isA<Exception>());
  });

  test('default massage', () {
    expect(servertExc.massage, null);
    expect(servertExc.toString(), 'Server Exception');
  });

  test('custom massage', () {
    final serverExc1 = ServerException(massage: 'error');
    expect(serverExc1.massage, 'error');
    expect(serverExc1.toString(), 'error');
  });
}
