import 'package:commath/features/presentation/router/route_name.dart';
import 'package:commath/features/presentation/screen/home_view/exam_screen.dart';
import 'package:commath/features/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screen/home_view/dashboard.dart';

class RoutesStore {
  List<GoRoute> getRoutes(GlobalKey<NavigatorState> key) {
    return <GoRoute>[
      GoRoute(
        name: RouteNames.login,
        path: '/login',
        parentNavigatorKey: key,
        builder: (context, state) => const LoginScreen(),
      ),
    ];
  }

  List<GoRoute> getShellRoutes(GlobalKey<NavigatorState> key) {
    return <GoRoute>[
      GoRoute(
        name: RouteNames.root,
        path: '/dashboard',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: DashboardView(),
        ),
        parentNavigatorKey: key,
      ),
      GoRoute(
        name: RouteNames.hasilExam,
        path: '/exam',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: ExamView(),
        ),
        parentNavigatorKey: key,
      ),
    ];
  }
}
