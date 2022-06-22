import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import 'exceptions/exception.dart';

class HttpService {
  HttpService(
    Client client,
    this.baseUrl, {
    this.getToken,
  }) : _client = client;

  final Client _client;
  final Future<String?>? getToken;
  final String baseUrl;

  String? token;

  /// Get a token and return header
  Future<Map<String, String>> getHeader() async {
    token ??= await getToken;

    final headers = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };
    if (token != null) headers['Authorization'] = 'Bearer $token';

    return headers;
  }

  /// Working with the response
  Future<Either<Exception, T>> responseType<T>(
    Response response,
    T Function(String body) fromJson,
  ) async {
    /// if the response is successful, return the data  fromJson
    if (response.statusCode == 200) {
      try {
        final model = fromJson(response.body);
        return Right(model);
      } catch (e) {
        return Left(ConvertExc(message: '$e'));
      }

      /// if an Unauthorized  return Authentication Exception
    } else if (response.statusCode == 401) {
      return Left(AuthenticationException());
    } else {
      /// if the response is not successful and unauthorized, it will return a server exception
      return Left(ServerException());
    }
  }

  /// Get Json data
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

  /// Perform a query using the "POST" method and using the JSON content type
  Future<Either<Exception, T>> post<T>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headerParams,
    required T Function(String body) fromJson,
  }) async {
    final header = await getHeader();
    final uri = buildUri(path, params: headerParams);
    final response = await _client.post(
      uri,
      headers: header,
      body: jsonEncode(body),
    );
    return responseType<T>(response, fromJson);
  }

  /// Perform a query using the "PATCH" method and using the JSON content type
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

  /// Perform a query using the "PUT" method and using the JSON content type
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
    final uri = Uri.parse(baseUrl + path);
    return uri;
  }
}
