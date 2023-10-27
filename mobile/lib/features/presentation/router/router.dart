import 'package:commath/dependency_injection.dart';
import 'package:commath/features/domain/repository/auth_repo.dart';
import 'package:commath/features/presentation/riverpod/navigator_provider.dart';
import 'package:commath/features/presentation/screen/404.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screen/home_screen.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final routeNavigator = ref.read(routeNavigatorKeyProvider);
  final shellNavigator = ref.read(shellNavigatorKeyProvider);
  bool isDuplicate = false;

  return GoRouter(
    navigatorKey: routeNavigator,
    initialLocation: '/login',
    redirect: (context, state) async {
      bool isLoggedIn = await sl<AuthRepository>().isLogedIn();
      final isGoingToLogin =
          state.location == '/login' || state.location == '/signup';

      if (!isLoggedIn && !isGoingToLogin && !isDuplicate) {
        isDuplicate = true;
        return '/login';
      }
      if (isLoggedIn && isGoingToLogin && !isDuplicate) {
        isDuplicate = true;
        return '/dashboard';
      }

      if (isDuplicate) {
        isDuplicate = false;
      }

      return null;
    },
    routes: [
      ...RoutesStore().getRoutes(routeNavigator),
      ShellRoute(
        navigatorKey: shellNavigator,
        builder: (context, state, child) => HomeScreen(child: child),
        routes: [...RoutesStore().getShellRoutes(shellNavigator)],
      ),
    ],
    errorBuilder: (context, state) {
      return Page404Error(
        key: state.pageKey,
      );
    },
  );
});
