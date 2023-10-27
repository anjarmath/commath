import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/presentation/widget/app_spacer.dart';
import 'package:commath/features/presentation/widget/custom_button.dart';
import 'package:commath/features/presentation/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPassword = useState<bool>(false);
    return Scaffold(
      backgroundColor: AppColor.light,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
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
                    const AppCustomInput(
                      label: 'Username',
                      prefix: HeroIcon(HeroIcons.user),
                    ),
                    const AppPaddingSpacer(),
                    AppCustomInput(
                      label: 'Password',
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
                      color: AppColor.primary,
                      text: Text(
                        'Masuk',
                        style: semibold16,
                      ),
                    ),
                  ],
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
                      child: Text(
                        'Daftar Dulu',
                        style: semibold16.copyWith(
                          color: AppColor.primary,
                        ),
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
