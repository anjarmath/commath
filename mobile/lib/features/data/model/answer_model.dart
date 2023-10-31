// ignore_for_file: non_constant_identifier_names

import 'package:commath/features/data/model/exam_model.dart';
import 'package:commath/features/domain/entity/answer_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_model.freezed.dart';
part 'answer_model.g.dart';

@freezed
class AnswerModel extends AnswerEntity with _$AnswerModel {
  factory AnswerModel({
    required String id,
    required String user_id,
    required String exam_id,
    required ExamModel exam,
    required String diketahui,
    required String ditanya,
    required String jawab,
    required String kesimpulan,
    String? feedback,
    required String created_at,
  }) = _AnswerModel;

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);
}
