import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/presentation/riverpod/navigator_provider.dart';
import 'package:commath/features/presentation/router/router.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Commath extends ConsumerWidget {
  const Commath({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final routeNavigator = ref.watch(routeNavigatorKeyProvider);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp.router(
      title: 'Commath',
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate, //2. registered route observer
      builder: (context, _) {
        var child = _!;
        // Wrap with toast.
        child = Toast(
          navigatorKey: routeNavigator,
          child: child,
        );
        return child;
      },
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
        fontFamily: 'Outfit',
      ),
      themeMode: ThemeMode.light,
    );
  }
}
