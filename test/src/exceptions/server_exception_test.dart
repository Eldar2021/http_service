import 'package:http_service1/http_service1.dart';
import 'package:test/test.dart';

void main() {
  final servertExc = ServerExc();

  test('is a type exception', () {
    expect(servertExc, isA<ServerExc>());
    expect(servertExc, isA<Exception>());
  });

  test('default massage', () {
    expect(servertExc.massage, null);
    expect(servertExc.toString(), 'Server Exception');
  });

  test('custom massage', () {
    final serverExc1 = ServerExc(massage: 'error');
    expect(serverExc1.massage, 'error');
    expect(serverExc1.toString(), 'error');
  });
}
