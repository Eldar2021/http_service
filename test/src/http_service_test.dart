import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:http_service1/http_service1.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../helper/fixture.dart';
import '../helper/model.dart';

class IMochClient extends Mock implements Client {}

Future<String> readToken() async => 'access_read_token';

final headerWithTokenF = {
  'Content-Type': 'application/json; charset=utf-8',
  'Accept': 'application/json',
  'Authorization': 'Bearer access_read_token',
};

final headerWithToken = {
  'Content-Type': 'application/json; charset=utf-8',
  'Accept': 'application/json',
  'Authorization': 'Bearer access_token',
};

final headerNoToken = {
  'Content-Type': 'application/json; charset=utf-8',
  'Accept': 'application/json',
};

void main() {
  final Client _client = IMochClient();
  final _service = HttpService(
    _client,
    'baseUrl',
    getToken: readToken(),
  );

  group('_service isNot null and is a type Http Service', () {
    test('can be instantiated', () {
      expect(_service, isNotNull);
    });

    test('is type HttpService', () {
      expect(_service, isA<HttpService>());
    });
  });

  group('_service get header function', () {
    test('get token function is not null', () async {
      expect(_service.getToken, isNotNull);
    });

    test('get token function is not null', () async {
      expect(_service.getToken, isNotNull);
    });

    test('get token function retirn is String', () async {
      final res = await _service.getToken;
      expect(res, isNotNull);
      expect(res, isA<String>());
      expect(res, 'access_read_token');
    });

    test('get token is not null', () async {
      expect(_service.token == null, true);
    });

    test('get header read token', () async {
      expect(_service.token == null, true);
      expect(_service.getToken != null, true);
      final res = await _service.getHeader();
      expect(res, isNotNull);
      expect(res, headerWithTokenF);
    });

    test('get header dont read but yes token', () async {
      _service.token = 'access_token';
      expect(_service.token != null, true);
      expect(_service.getToken != null, true);
      final res = await _service.getHeader();
      expect(res, isNotNull);
      expect(res, headerWithToken);
    });

    test('get header dont read but no token', () async {
      final _serviceNoFiction = HttpService(
        _client,
        'baseUrl',
      );
      expect(_serviceNoFiction.token == null, true);
      expect(_serviceNoFiction.getToken == null, true);
      final res = await _serviceNoFiction.getHeader();
      expect(res, isNotNull);
      expect(res, headerNoToken);
    });
  });

  group('method', () {
    test('get Method responseType 200', () async {
      final headers = await _service.getHeader();
      final path = _service.buildUri('path');

      when(() => _client.get(path, headers: headers)).thenAnswer(
        (i) async => Response(fixture('fake'), 200),
      );

      final res = await _service.get<List<Model>>(
        'path',
        fromJson: modelFromJson,
      );

      expect(res, isA<Right<Exception, List<Model>>>());
    });

    test('post Method responseType 401', () async {
      final header = await _service.getHeader();
      final path = _service.buildUri('path');
      const body = {'id': 1};

      when(
        () => _client.post(path, headers: header, body: jsonEncode(body)),
      ).thenAnswer(
        (i) async => Response('Left 401', 401),
      );

      final res = await _service.post<List<Model>>(
        'path',
        fromJson: modelFromJson,
        body: body,
      );

      expect(res, isA<Left<Exception, List<Model>>>());
    });

    test('patch Method  200 but convertException', () async {
      final header = await _service.getHeader();
      final path = _service.buildUri('path');
      const body = {'id': 1};

      when(
        () => _client.patch(path, headers: header, body: jsonEncode(body)),
      ).thenAnswer(
        (i) async => Response('Left 401', 200),
      );

      final res = await _service.patch<List<Model>>(
        'path',
        fromJson: modelFromJson,
        body: body,
      );

      expect(res, isA<Left<Exception, List<Model>>>());
    });

    test('patch Method  500 but convertException', () async {
      final header = await _service.getHeader();
      final path = _service.buildUri('path');
      const body = {'id': 1};

      when(
        () => _client.put(path, headers: header, body: jsonEncode(body)),
      ).thenAnswer(
        (i) async => Response('Server exception 500', 500),
      );

      final res = await _service.put<List<Model>>(
        'path',
        fromJson: modelFromJson,
        body: body,
      );

      expect(res, isA<Left<Exception, List<Model>>>());
    });
  });
}
