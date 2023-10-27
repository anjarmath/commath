import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routeNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>(debugLabel: 'route');
});
final shellNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>(debugLabel: 'shell');
});

final navBarProvider = StateNotifierProvider<NavBarStateNotifier, int>(
    (ref) => NavBarStateNotifier(0));

class NavBarStateNotifier extends StateNotifier<int> {
  NavBarStateNotifier(super.state);

  void setPosition(int index) {
    state = index;
  }
}
