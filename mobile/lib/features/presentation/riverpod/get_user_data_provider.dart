import 'dart:async';

import 'package:commath/dependency_injection.dart';
import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/error/error_status_code.dart';
import 'package:commath/features/core/state/notifier_state.dart';
import 'package:commath/features/domain/entity/user_entity.dart';
import 'package:commath/features/domain/repository/auth_repo.dart';
import 'package:commath/features/presentation/controller/invalid_session_controller.dart';
import 'package:commath/features/presentation/riverpod/navigator_provider.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userDataNotifierProvider = ChangeNotifierProvider((ref) {
  final context = ref.read(routeNavigatorKeyProvider).currentContext;
  return UserDataNotifier(context!);
});

class UserDataNotifier extends ChangeNotifier {
  final BuildContext context;
  Timer? _timer;
  UserDataNotifier(this.context) : super() {
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => initUser());
    initUser();
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

  UserEntity _data = UserEntity.emptyUser();
  UserEntity get data => _data;
  void setUser(UserEntity data) {
    _data = data;
    _setState(NotifierState.loaded);
    notifyListeners();
  }

  void initUser() async {
    _setLoading(true);

    if (_timer != null && _timer!.isActive) {
      debugPrint('Getting user data...!');
      final userModel = await sl<AuthRepository>().getAndUpdateUser();
      userModel.fold(
        (l) {
          if (l.statusCode == SystemFailureStatusCode.authError) {
            reset();
            invalidSessionHandler(context);
          } else {
            context.showErrorBar(
              content: Text(l.getMessage()),
              position: FlashPosition.top,
              indicatorColor: AppColor.error,
            );
          }
        },
        (r) {
          setUser(r);
        },
      );
    }
    _setLoading(false);
  }

  void reset() {
    _timer!.cancel();
    setUser(UserEntity.emptyUser());
    _setState(NotifierState.initial);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 15), (_) => initUser());
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
