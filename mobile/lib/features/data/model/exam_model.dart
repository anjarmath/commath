// ignore_for_file: non_constant_identifier_names

import 'package:commath/features/domain/entity/exam_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_model.freezed.dart';
part 'exam_model.g.dart';

@freezed
class ExamModel extends ExamEntity with _$ExamModel {
  factory ExamModel({
    required String id,
    required String company_id,
    required String topic_id,
    required String question,
  }) = _ExamModel;

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);
}
