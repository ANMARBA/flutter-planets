import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:http/http.dart' as http;

import 'package:flutter_planets/core/domain/entities/exceptions.dart';
import 'package:flutter_planets/core/domain/repositories/network_repository.dart';
import 'package:flutter_planets/core/shared/constants/constants.dart';
import 'package:flutter_planets/core/shared/di/locator.dart';

part 'server_log.dart';

class ServerApiClient {
  final NetworkInfoRepository _networkInfoRepository =
      locator<NetworkInfoRepository>();

  Future<void> _ensureConnection() async {
    if (!await _networkInfoRepository.hasConnection) {
      throw ConnectionException(message: Constants.noInternetConnection);
    }
  }

  Map<String, String> _mergeHeaders(Map<String, String>? headers) {
    final all = <String, String>{};
    if (headers != null) all.addAll(headers);
    all.putIfAbsent('Content-Type', () => 'application/json');
    return all;
  }

  Uri _buildUri({
    required String path,
    String? host,
    String scheme = 'https',
    Map<String, dynamic>? queryParameters,
  }) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      final u = Uri.parse(path);
      return u.replace(queryParameters: queryParameters);
    }

    return Uri(
      scheme: scheme,
      host: host ?? serverAuthority,
      path: path,
      queryParameters: queryParameters,
    );
  }

  Future<http.Response> _send({
    required String method,
    required String path,
    String? host,
    String scheme = 'https',
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    await _ensureConnection();

    final url = _buildUri(
      path: path,
      host: host,
      scheme: scheme,
      queryParameters: queryParameters,
    );
    final allHeaders = _mergeHeaders(headers);

    http.Response res;
    try {
      switch (method) {
        case 'GET':
          res = await http.get(url, headers: allHeaders);
          break;
        default:
          throw HttpException(message: 'HTTP method not supported: $method');
      }
    } catch (e) {
      throw HttpException(message: 'HTTP request error: ${e.toString()}');
    }

    if (kDebugMode) log(_formatResponseLog(res));
    return res;
  }

  Future<http.Response> get(
    String path, {
    String? host,
    String serverSchema = 'https',
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) =>
      _send(
        method: 'GET',
        path: path,
        host: host,
        scheme: serverSchema,
        queryParameters: queryParameters,
        headers: headers,
      );
}
