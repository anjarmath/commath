import 'dart:convert';
import 'dart:io';

import 'package:commath/features/core/error/error.dart';
import 'package:commath/features/core/error/error_status_code.dart';
import 'package:commath/features/core/external/env.dart';
import 'package:commath/features/core/network/connection_type.dart';
import 'package:commath/features/core/network/connectivity.dart';
import 'package:commath/features/core/state/api_response.dart';
import 'package:commath/features/core/state/data_state.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import 'api_data_source.dart';

class ApiDataSourceImplHttp implements ApiDataSource {
  final String? _baseUrl;
  final ConnectivityRepository _connectivityRepository;

  ApiDataSourceImplHttp(this._connectivityRepository)
      : _baseUrl = EnvironmentConfig.backendBaseUrl;

  @override
  String? get baseUrl => _baseUrl;

  @override
  DataState<ApiResponse> sendPost({
    required String path,
    required String body,
    String? userId,
    required ConnectionType connectionType,
    String? token,
    Map<String, dynamic>? params,
  }) async {
    if (!await _connectivityRepository.isConnected()) {
      return left(
        Failure(
          statusCode: SystemFailureStatusCode.networkError,
          message: 'Tidak tersambung ke internet',
        ),
      );
    }
    final url = Uri.parse('$_baseUrl/$path').replace(queryParameters: params);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (connectionType == ConnectionType.private)
            'Authorization': 'Bearer $token',
          'UserID': '$userId',
        },
        body: body,
      );

      return right(ApiResponse(
          data: jsonDecode(response.body), statusCode: response.statusCode));
    } catch (e) {
      return left(
        Failure(
          statusCode: SystemFailureStatusCode.unknownError,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  DataState<ApiResponse> sendGet({
    required String path,
    required ConnectionType connectionType,
    String? userId,
    String? token,
    Map<String, dynamic>? params,
  }) async {
    if (!await _connectivityRepository.isConnected()) {
      return left(
        Failure(
          statusCode: SystemFailureStatusCode.networkError,
          message: 'Tidak tersambung ke internet',
        ),
      );
    }
    try {
      final url = Uri.parse('$_baseUrl/$path').replace(queryParameters: params);

      final headers = {
        'Content-Type': 'application/json',
        'UserID': '$userId',
        if (connectionType == ConnectionType.private)
          'Authorization': 'Bearer ${token!}',
      };

      final response = await http.get(url, headers: headers);

      return right(ApiResponse(
          data: jsonDecode(response.body), statusCode: response.statusCode));
    } catch (e) {
      return left(
        Failure(
          statusCode: SystemFailureStatusCode.unknownError,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  DataState<ApiResponse> sendPatch(
      {required String path,
      required String body,
      String? userId,
      required ConnectionType connectionType,
      String? token,
      Map<String, dynamic>? params}) async {
    if (!await _connectivityRepository.isConnected()) {
      return left(
        Failure(
          statusCode: SystemFailureStatusCode.networkError,
          message: 'Tidak tersambung ke internet',
        ),
      );
    }
    final url = Uri.parse('$_baseUrl/$path').replace(queryParameters: params);

    try {
      final response = await http.patch(url,
          headers: {
            'Content-Type': 'application/json',
            'UserID': '$userId',
            if (connectionType == ConnectionType.private)
              'Authorization': 'Bearer $token',
          },
          body: body);

      return right(ApiResponse(
          data: jsonDecode(response.body), statusCode: response.statusCode));
    } catch (e) {
      return left(
        Failure(
          statusCode: SystemFailureStatusCode.unknownError,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  DataState<ApiResponse> sendPostWithFile(
      {required String path,
      String? body,
      required ConnectionType connectionType,
      String? userId,
      String? token,
      Map<String, dynamic>? params,
      required File file}) async {
    if (!await _connectivityRepository.isConnected()) {
      return left(
        Failure(
          statusCode: SystemFailureStatusCode.networkError,
          message: 'Tidak tersambung ke internet',
        ),
      );
    }

    final url = Uri.parse('$_baseUrl/$path').replace(queryParameters: params);

    try {
      final request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('image', file.path));
      request.headers.addAll({
        'UserID': '$userId',
        if (connectionType == ConnectionType.private)
          'Authorization': 'Bearer $token',
      });
      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      return right(ApiResponse(
          data: jsonDecode(response.body), statusCode: response.statusCode));
    } catch (e) {
      return left(
        Failure(
          statusCode: SystemFailureStatusCode.unknownError,
          message: e.toString(),
        ),
      );
    }
  }
}
