import 'package:commath/features/core/state/data_state.dart';
import 'package:commath/features/domain/entity/answer_entity.dart';
import 'package:commath/features/domain/entity/company_entity.dart';
import 'package:commath/features/domain/entity/exam_entity.dart';
import 'package:commath/features/domain/entity/topic_entity.dart';

abstract class ExamRepository {
  DataState<List<TopicEntity>> getAllTopic();
  DataState<List<CompanyEntity>> getAllCompany();
  DataState<ExamEntity> getCompanyExam(String companyId);
  DataState<List<AnswerEntity>> getAllUserAnswer();
  DataState<bool> submitAnswer({
    required String examId,
    required String diketahui,
    required String ditanya,
    required String jawab,
    required String kesimpulan,
  });
}
