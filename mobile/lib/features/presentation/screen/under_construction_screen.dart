import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/presentation/riverpod/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class UnderConstructionScreen extends ConsumerWidget {
  const UnderConstructionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void goToDashboard() {
      ref.read(navBarProvider.notifier).setPosition(0);
      context.go('/dashboard');
    }

    return WillPopScope(
      onWillPop: () {
        goToDashboard();
        return Future.value(false);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                'assets/lottie/otw.json',
                width: MediaQuery.of(context).size.width * .6,
                fit: BoxFit.contain,
                repeat: true,
              ),
              const SizedBox(height: 12),
              Text(
                'Oops!',
                style: bold20.copyWith(
                  color: AppColor.error,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Fitur akan segera tiba',
                style: regular14.copyWith(
                  color: AppColor.base,
                ),
              ),
              const SizedBox(height: 20),
              Material(
                  // child: AppCustomButton(
                  //   text: const Text('Kembali'),
                  //   color: AppColor.primary,
                  //   onPressed: () {
                  //     goToDashboard();
                  //   },
                  // ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
