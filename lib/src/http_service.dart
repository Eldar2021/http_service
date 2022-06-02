import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import 'exceptions/exception.dart';

class HttpService {
  HttpService(
    Client client,
    String baseUrl, {
    Future<String?>? getToken,
  })  : _getToken = getToken,
        _client = client,
        _baseUrl = baseUrl;

  final Client _client;
  final Future<String?>? _getToken;
  final String _baseUrl;

  String? _token;

  Future<Map<String, String>> getHeader() async {
    // ignore: unnecessary_statements
    if (_getToken == null) _token ?? (_token = await _getToken);

    final headers = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };
    if (_token != null) headers['Authorization'] = 'Bearer $_token';

    return headers;
  }

  Future<Either<Exception, T>> responseType<T>(
    Response response,
    T Function(String body) fromJson,
  ) async {
    if (response.statusCode == 200) {
      try {
        final model = fromJson(response.body);
        return Right(model);
      } catch (e) {
        return Left(ConvertExc(massage: '$e'));
      }
    } else if (response.statusCode == 401) {
      return Left(AuthExc());
    } else {
      return Left(ServerExc());
    }
  }

  Future<Either<Exception, T>> get<T>(
    String path, {
    Map<String, dynamic>? params,
    required T Function(String body) fromJson,
  }) async {
    final header = await getHeader();
    final response = await _client.get(
      buildUri(path, params: params),
      headers: header,
    );
    return responseType<T>(response, fromJson);
  }

  Future<Either<Exception, T>> post<T>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headerParams,
    required T Function(String body) fromJson,
  }) async {
    final header = await getHeader();
    final uri = buildUri(path, params: headerParams);
    final response = await _client.post(uri, headers: header);
    return responseType<T>(response, fromJson);
  }

  Future<Either<Exception, T>> patch<T>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headerParams,
    required T Function(String body) fromJson,
  }) async {
    final header = await getHeader();
    final response = await _client.patch(
      buildUri(path, params: headerParams),
      body: jsonEncode(body),
      headers: header,
    );
    return responseType<T>(response, fromJson);
  }

  Future<Either<Exception, T>> put<T>(
    String path, {
    Map<String, dynamic>? body,
    required T Function(String body) fromJson,
  }) async {
    final header = await getHeader();
    final response = await _client.put(
      buildUri(path),
      body: jsonEncode(body),
      headers: header,
    );
    return responseType<T>(response, fromJson);
  }

  Uri buildUri(String path, {Map<String, dynamic>? params}) {
    final uri = Uri.parse(_baseUrl + path);
    return uri;
  }
}
