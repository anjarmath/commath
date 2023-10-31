import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/presentation/riverpod/navigator_provider.dart';
import 'package:commath/features/presentation/router/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavIndex = ref.watch(navBarProvider);
    final navList = <NavBarItem>[
      NavBarItem(
        icon: HeroIcons.home,
        routeName: RouteNames.root,
      ),
      NavBarItem(
        icon: HeroIcons.clipboardDocumentCheck,
        routeName: RouteNames.hasilExam,
      ),
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () {
          context.pushNamed(RouteNames.selectTopic);
        },
        child: const HeroIcon(
          HeroIcons.academicCap,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (var i = 0; i < navList.length; i++)
              IconButton(
                onPressed: () {
                  ref.read(navBarProvider.notifier).setPosition(i);
                  context.goNamed(navList[i].routeName);
                },
                icon: HeroIcon(
                  navList[i].icon,
                  size: 48,
                  color:
                      i == bottomNavIndex ? AppColor.secondary : AppColor.base,
                  style: i == bottomNavIndex
                      ? HeroIconStyle.solid
                      : HeroIconStyle.outline,
                ),
              )
          ],
        ),
      ),
      body: child,
    );
  }
}

class NavBarItem {
  final String routeName;
  final HeroIcons icon;

  const NavBarItem({
    required this.icon,
    required this.routeName,
  });
}
