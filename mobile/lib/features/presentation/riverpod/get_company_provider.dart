import 'package:commath/dependency_injection.dart';
import 'package:commath/features/core/state/notifier_state.dart';
import 'package:commath/features/domain/entity/company_entity.dart';
import 'package:commath/features/domain/repository/exam_repo.dart';
import 'package:commath/features/presentation/riverpod/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getCompanyNotifierProvider = ChangeNotifierProvider((ref) {
  final context = ref.watch(routeNavigatorKeyProvider).currentContext;
  return GetCompanyNotifier(context!);
});

class GetCompanyNotifier extends ChangeNotifier {
  BuildContext context;
  GetCompanyNotifier(this.context) : super() {
    getCompany();
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

  List<CompanyEntity> _company = List.generate(
    1,
    (index) => const CompanyEntity(
      id: '',
      name: '',
      profile: '',
      cover: '',
      description: '',
      problem: '',
      verified: false,
    ),
  );
  List<CompanyEntity> get company => _company;
  void _setCompany(List<CompanyEntity> company) {
    _company = company;
    _setState(NotifierState.loaded);
    notifyListeners();
  }

  void getCompany() async {
    _setLoading(true);

    final res = await sl<ExamRepository>().getAllCompany();

    res.fold((l) => null, (r) => _setCompany(r));

    _setLoading(false);
  }
}
