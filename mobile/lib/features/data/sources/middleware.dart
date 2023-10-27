import 'dart:convert';

import 'package:commath/features/core/state/api_response.dart';
import 'package:commath/features/core/state/data_state.dart';
import 'package:commath/features/data/model/user_model.dart';
import 'package:commath/features/data/sources/secure_storage.dart';

/// Token manager is used to intercept the request made to the server (frontend middleware)
abstract class Middleware {
  /// It will send the API Call to specific [apiCall] method, it will use current user access token,
  /// When the token is expired, it will intercept the response and call refresh access token to backend instead,
  /// When it get the new access token it will resend the API Call using new [token], otherwise it will return ErrorType.notAuthenticated error
  ///
  /// Example of use:
  ///
  ///
  /// ```dart
  /// TokenManager.execute((token) => _someApiService.sendGet(token:token));
  /// ```
  DataState<ApiResponse> execute(
      DataState<ApiResponse> Function(String? token, String userId) apiCall);
}

class MiddlewareImpl implements Middleware {
  final SecureStorage _secureStorage;

  const MiddlewareImpl(this._secureStorage);
  @override
  DataState<ApiResponse> execute(
      DataState<ApiResponse> Function(String? token, String userId)
          apiCall) async {
    final userFromStorage = await _secureStorage.getFromStorage('user');
    final user = UserModel.fromJson(jsonDecode(userFromStorage));

    final apiResult = await apiCall(user.access_token, user.id);

    return apiResult;
  }
}
