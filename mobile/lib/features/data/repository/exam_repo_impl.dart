import 'dart:convert';

import 'package:commath/features/core/error/error.dart';
import 'package:commath/features/core/error/error_status_code.dart';
import 'package:commath/features/core/network/connection_type.dart';
import 'package:commath/features/core/state/data_state.dart';
import 'package:commath/features/data/model/answer_model.dart';
import 'package:commath/features/data/model/company_model.dart';
import 'package:commath/features/data/model/exam_model.dart';
import 'package:commath/features/data/model/topic_model.dart';
import 'package:commath/features/data/model/user_model.dart';
import 'package:commath/features/data/sources/api_data_source.dart';
import 'package:commath/features/data/sources/middleware.dart';
import 'package:commath/features/data/sources/secure_storage.dart';
import 'package:commath/features/domain/repository/exam_repo.dart';
import 'package:fpdart/fpdart.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ApiDataSource _apiDataSource;
  final SecureStorage _secureStorage;
  final Middleware _middleware;

  const ExamRepositoryImpl(
      this._apiDataSource, this._secureStorage, this._middleware);

  @override
  DataState<List<CompanyModel>> getAllCompany() async {
    final res = await _apiDataSource.sendGet(
        path: 'company', connectionType: ConnectionType.public);
    return res.fold(
      (l) => left(l),
      (r) {
        List<dynamic> data = r.data;
        List<CompanyModel> resList =
            data.map((json) => CompanyModel.fromJson(json)).toList();
        return right(resList);
      },
    );
  }

  @override
  DataState<List<TopicModel>> getAllTopic() async {
    final res = await _apiDataSource.sendGet(
        path: 'topic', connectionType: ConnectionType.public);
    return res.fold(
      (l) => left(l),
      (r) {
        List<dynamic> data = r.data;
        List<TopicModel> resList =
            data.map((json) => TopicModel.fromJson(json)).toList();
        return right(resList);
      },
    );
  }

  @override
  DataState<List<AnswerModel>> getAllUserAnswer() async {
    try {
      final userFromStorage = await _secureStorage.getFromStorage('user');
      final user = UserModel.fromJson(jsonDecode(userFromStorage));
      final params = {
        "user_id": user.id,
      };
      final res = await _apiDataSource.sendGet(
        path: 'answer/user',
        connectionType: ConnectionType.public,
        params: params,
      );
      return res.fold(
        (l) => left(l),
        (r) {
          List<dynamic> data = r.data;
          List<AnswerModel> resList =
              data.map((json) => AnswerModel.fromJson(json)).toList();
          return right(resList);
        },
      );
    } catch (_) {
      return left(Failure(
          statusCode: SystemFailureStatusCode.authError,
          message: 'Sesi berakhir'));
    }
  }

  @override
  DataState<ExamModel> getCompanyExam(String companyId) async {
    final params = {
      "company_id": companyId,
    };
    final res = await _apiDataSource.sendGet(
      path: 'exam',
      connectionType: ConnectionType.public,
      params: params,
    );
    return res.fold((l) => left(l), (r) => right(ExamModel.fromJson(r.data)));
  }

  @override
  DataState<bool> submitAnswer(
      {required String examId,
      required String diketahui,
      required String ditanya,
      required String jawab,
      required String kesimpulan}) async {
    final body = jsonEncode(<String, String>{
      "exam_id": examId,
      "diketahui": diketahui,
      "ditanya": ditanya,
      "jawab": jawab,
      "kesimpulan": kesimpulan,
    });
    final res = await _middleware.execute(
      (token, userId) => _apiDataSource.sendPost(
        path: 'answer',
        body: body,
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
          return left(
              Failure(statusCode: r.statusCode, message: r.data["message"]));
        } else {
          return right(true);
        }
      },
    );
  }
}
