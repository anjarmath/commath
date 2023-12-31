// ignore_for_file: non_constant_identifier_names

import 'package:commath/features/domain/entity/exam_entity.dart';

class AnswerEntity {
  final String id;
  final String user_id;
  final String exam_id;
  final ExamEntity exam;
  final String diketahui;
  final String ditanya;
  final String jawab;
  final String kesimpulan;
  final String? feedback;
  final String created_at;

  const AnswerEntity({
    required this.id,
    required this.user_id,
    required this.exam_id,
    required this.exam,
    required this.diketahui,
    required this.ditanya,
    required this.jawab,
    required this.kesimpulan,
    required this.feedback,
    required this.created_at,
  });
}
