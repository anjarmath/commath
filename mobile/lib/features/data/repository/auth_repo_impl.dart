import 'dart:convert';

import 'package:commath/features/core/error/error.dart';
import 'package:commath/features/core/error/error_status_code.dart';
import 'package:commath/features/core/network/connection_type.dart';
import 'package:commath/features/core/state/data_state.dart';
import 'package:commath/features/data/model/class_model.dart';
import 'package:commath/features/data/model/school_model.dart';
import 'package:commath/features/data/model/user_model.dart';
import 'package:commath/features/data/sources/api_data_source.dart';
import 'package:commath/features/data/sources/middleware.dart';
import 'package:commath/features/data/sources/secure_storage.dart';
import 'package:commath/features/domain/entity/user_entity.dart';
import 'package:commath/features/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiDataSource _apiDataSource;
  final SecureStorage _secureStorage;
  final Middleware _middleware;

  const AuthRepositoryImpl(
      this._apiDataSource, this._secureStorage, this._middleware);

  @override
  DataState<List<SchoolModel>> getAllSchool() async {
    final res = await _apiDataSource.sendGet(
        path: 'school', connectionType: ConnectionType.public);
    return res.fold(
      (l) => left(l),
      (r) {
        List<dynamic> data = r.data;
        List<SchoolModel> resList =
            data.map((json) => SchoolModel.fromJson(json)).toList();
        return right(resList);
      },
    );
  }

  @override
  DataState<List<ClassModel>> getAllSchoolClass(String schoolId) async {
    final params = {
      "school_id": schoolId,
    };
    final res = await _apiDataSource.sendGet(
      path: 'class',
      connectionType: ConnectionType.public,
      params: params,
    );
    return res.fold(
      (l) => left(l),
      (r) {
        List<dynamic> data = r.data;
        List<ClassModel> resList =
            data.map((json) => ClassModel.fromJson(json)).toList();
        return right(resList);
      },
    );
  }

  @override
  DataState<UserEntity> getAndUpdateUser() async {
    try {
      final userFromStorage = await _secureStorage.getFromStorage('user');
      final user = UserModel.fromJson(jsonDecode(userFromStorage));
      final id = user.id;
      final res = await _middleware.execute(
        (token, userId) => _apiDataSource.sendGet(
          path: 'user/$id',
          connectionType: ConnectionType.private,
          token: token,
          userId: userId,
        ),
      );

      return res.fold(
        (l) {
          return left(l);
        },
        (r) {
          if (r.statusCode != 200) {
            return left(Failure(
              statusCode: r.statusCode,
              message: r.data["message"],
            ));
          } else {
            _secureStorage.deleteFromStorage('user');
            _secureStorage.saveToStorage('user', jsonEncode(r.data));
            return right(UserModel.fromJson(r.data));
          }
        },
      );
    } catch (_) {
      return left(Failure(
          statusCode: SystemFailureStatusCode.authError,
          message: 'Sesi berakhir'));
    }
  }

  @override
  DataState<UserEntity> getUser() async {
    try {
      final user = await _secureStorage.getFromStorage('user');
      return right(UserModel.fromJson(user));
    } catch (e) {
      return left(
        Failure(
          statusCode: SystemFailureStatusCode.authError,
          message: 'Anda belum login',
        ),
      );
    }
  }

  @override
  Future<bool> isLogedIn() async {
    return await _secureStorage.checkFromStorage('user');
  }

  @override
  DataState<UserModel> login(String username, String password) async {
    final body = jsonEncode(<String, String>{
      "username": username,
      "password": password,
    });
    final res = await _apiDataSource.sendPost(
      path: 'login',
      body: body,
      connectionType: ConnectionType.public,
    );
    return res.fold(
      (l) {
        return left(l);
      },
      (r) {
        if (r.statusCode != 200) {
          return left(Failure(
            statusCode: r.statusCode,
            message: r.data["message"],
          ));
        } else {
          _secureStorage.saveToStorage('user', jsonEncode(r.data));
          try {
            return right(UserModel.fromJson(r.data));
          } catch (e) {
            return left(Failure(
                statusCode: SystemFailureStatusCode.parsingError,
                message: 'Cannot parse user'));
          }
        }
      },
    );
  }

  @override
  Future<void> logout() async {
    return _secureStorage.deleteFromStorage('user');
  }

  @override
  DataState<bool> register(
      {required String username,
      required String name,
      required String password,
      required String confPassword,
      required String classId}) async {
    final body = jsonEncode(<String, String>{
      "username": username,
      "name": name,
      "password": password,
      "conf_password": confPassword,
      "class_id": classId,
    });
    final res = await _apiDataSource.sendPost(
        path: 'signup', body: body, connectionType: ConnectionType.public);
    return res.fold(
      (l) {
        return left(l);
      },
      (r) {
        if (r.statusCode != 200) {
          return left(
              Failure(statusCode: r.statusCode, message: r.data["message"]));
        } else {
          return right(true);
        }
      },
    );
  }
}
