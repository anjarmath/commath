import 'package:commath/dependency_injection.dart';
import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/domain/repository/auth_repo.dart';
import 'package:commath/features/presentation/router/route_name.dart';
import 'package:commath/features/presentation/widget/app_spacer.dart';
import 'package:commath/features/presentation/widget/custom_button.dart';
import 'package:commath/features/presentation/widget/custom_input.dart';
import 'package:commath/features/presentation/widget/loading_overlay.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../riverpod/get_user_data_provider.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState<bool>(false);
    final showPassword = useState<bool>(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    Future<void> login() async {
      isLoading.value = true;

      final res = await sl<AuthRepository>()
          .login(usernameController.text, passwordController.text);
      res.fold(
        (l) => context.showErrorBar(content: Text(l.getMessage())),
        (r) {
          ref.read(userDataNotifierProvider.notifier).setUser(r);
          ref.read(userDataNotifierProvider.notifier).startTimer();
          context.go('/dashboard');
        },
      );

      isLoading.value = false;
    }

    return Scaffold(
      backgroundColor: AppColor.light,
      body: LoadingOverlay(
        isLoading: isLoading.value,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Masuk',
                          style: title24.copyWith(
                            color: AppColor.primary,
                          ),
                        ),
                        const AppPaddingSpacer(),
                        Text(
                          'Selamat datang kembali jagoan!',
                          style: regular14,
                        ),
                        const AppPaddingSpacer(),
                        AppCustomInput(
                          cannotEmpty: true,
                          controller: usernameController,
                          label: 'Username',
                          prefix: const HeroIcon(HeroIcons.user),
                        ),
                        const AppPaddingSpacer(),
                        AppCustomInput(
                          cannotEmpty: true,
                          label: 'Password',
                          controller: passwordController,
                          prefix: const HeroIcon(HeroIcons.key),
                          suffix: GestureDetector(
                            onTap: () {
                              showPassword.value = !showPassword.value;
                            },
                            child: Icon(
                              showPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColor.base,
                            ),
                          ),
                        ),
                        const AppPaddingSpacer(),
                        AppCustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                !isLoading.value) {
                              login();
                            }
                          },
                          color: AppColor.primary,
                          text: Text(
                            'Masuk',
                            style: semibold16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: 'Pengguna Baru? Yuk ',
                    style: semibold16.copyWith(
                      color: AppColor.base,
                    ),
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            context.goNamed(RouteNames.signup);
                          },
                          child: Text(
                            'Daftar Dulu',
                            style: semibold16.copyWith(
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
