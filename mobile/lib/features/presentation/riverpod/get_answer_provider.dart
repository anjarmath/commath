import 'package:commath/dependency_injection.dart';
import 'package:commath/features/core/state/notifier_state.dart';
import 'package:commath/features/domain/entity/answer_entity.dart';
import 'package:commath/features/domain/entity/exam_entity.dart';
import 'package:commath/features/domain/repository/exam_repo.dart';
import 'package:commath/features/presentation/riverpod/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getAnswerNotifierProvider = ChangeNotifierProvider((ref) {
  final context = ref.watch(routeNavigatorKeyProvider).currentContext;
  return GetAnswerNotifier(context!);
});

class GetAnswerNotifier extends ChangeNotifier {
  BuildContext context;
  GetAnswerNotifier(this.context) : super() {
    getAnswer();
  }

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  List<AnswerEntity> _answer = List.generate(
      1,
      (index) => const AnswerEntity(
          id: '',
          user_id: '',
          exam_id: '',
          exam: ExamEntity(
            id: '',
            company_id: '',
            topic_id: '',
            question: '',
          ),
          diketahui: '',
          ditanya: '',
          jawab: '',
          kesimpulan: '',
          feedback: '',
          created_at: ''));
  List<AnswerEntity> get answer => _answer;
  void _setAnswer(List<AnswerEntity> answer) {
    _answer = answer;
    _setState(NotifierState.loaded);
    notifyListeners();
  }

  void getAnswer() async {
    _setLoading(true);

    final res = await sl<ExamRepository>().getAllUserAnswer();

    res.fold((l) => null, (r) => _setAnswer(r));

    _setLoading(false);
  }
}
