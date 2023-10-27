import 'dart:io';

import 'package:commath/features/core/network/connection_type.dart';
import 'package:commath/features/core/state/api_response.dart';
import 'package:commath/features/core/state/data_state.dart';

abstract class ApiDataSource {
  String? get baseUrl;

  DataState<ApiResponse> sendPost({
    required String path,
    required String body,
    String? userId,
    required ConnectionType connectionType,
    String? token,
    Map<String, dynamic>? params,
  });

  DataState<ApiResponse> sendPostWithFile({
    required String path,
    String? body,
    String? userId,
    required ConnectionType connectionType,
    String? token,
    Map<String, dynamic>? params,
    required File file,
  });

  DataState<ApiResponse> sendPatch({
    required String path,
    required String body,
    String? userId,
    required ConnectionType connectionType,
    String? token,
    Map<String, dynamic>? params,
  });

  DataState<ApiResponse> sendGet({
    required String path,
    String? userId,
    required ConnectionType connectionType,
    String? token,
    Map<String, dynamic>? params,
  });
}
