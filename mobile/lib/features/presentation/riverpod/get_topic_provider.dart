import 'package:commath/dependency_injection.dart';
import 'package:commath/features/core/state/notifier_state.dart';
import 'package:commath/features/domain/entity/topic_entity.dart';
import 'package:commath/features/domain/repository/exam_repo.dart';
import 'package:commath/features/presentation/riverpod/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getTopicNotifierProvider = ChangeNotifierProvider((ref) {
  final context = ref.watch(routeNavigatorKeyProvider).currentContext;
  return GetTopicNotifier(context!);
});

class GetTopicNotifier extends ChangeNotifier {
  BuildContext context;
  GetTopicNotifier(this.context) : super() {
    getTopic();
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

  List<TopicEntity> _topic = List.generate(
    1,
    (index) => const TopicEntity(
      id: '',
      name: '',
    ),
  );
  List<TopicEntity> get topic => _topic;
  void _setTopic(List<TopicEntity> topic) {
    _topic = topic;
    _setState(NotifierState.loaded);
    notifyListeners();
  }

  void getTopic() async {
    _setLoading(true);

    final res = await sl<ExamRepository>().getAllTopic();

    res.fold((l) => null, (r) => _setTopic(r));

    _setLoading(false);
  }
}
