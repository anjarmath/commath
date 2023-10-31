import 'package:commath/dependency_injection.dart';
import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/domain/entity/class_entity.dart';
import 'package:commath/features/domain/entity/school_entity.dart';
import 'package:commath/features/domain/repository/auth_repo.dart';
import 'package:commath/features/presentation/router/route_name.dart';
import 'package:commath/features/presentation/widget/custom_dialog.dart';
import 'package:commath/features/presentation/widget/loading_overlay.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widget/app_spacer.dart';
import '../widget/custom_button.dart';
import '../widget/custom_input.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState<bool>(false);
    final showPassword = useState<bool>(false);

    final listOfSchool = useState<List<SchoolEntity>>([]);
    final listOfClass = useState<List<ClassEntity>>([]);
    final selectedClassId = useState<String>('');

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final usernameController = useTextEditingController();
    final nameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confPasswordController = useTextEditingController();

    Future<void> getSchools() async {
      isLoading.value = true;
      final res = await sl<AuthRepository>().getAllSchool();

      res.fold(
        (l) => context.showErrorBar(content: Text(l.getMessage())),
        (r) {
          listOfSchool.value = r;
        },
      );
      isLoading.value = false;
    }

    Future<void> getClasses(String schoolId) async {
      isLoading.value = true;
      final res = await sl<AuthRepository>().getAllSchoolClass(schoolId);

      res.fold(
        (l) => context.showErrorBar(content: Text(l.getMessage())),
        (r) {
          listOfClass.value = r;
        },
      );
      isLoading.value = false;
    }

    Future<void> register() async {
      isLoading.value = true;

      if (selectedClassId.value == '') {
        context.showErrorBar(content: const Text("Pilih kelas!"));
        return;
      }
      final res = await sl<AuthRepository>().register(
        username: usernameController.text,
        name: nameController.text,
        password: passwordController.text,
        confPassword: confPasswordController.text,
        classId: selectedClassId.value,
      );

      res.fold((l) => context.showErrorBar(content: Text(l.getMessage())), (r) {
        showDialog(
          context: context,
          builder: (context) {
            return AppAlertDialog(
              message: 'Akun berhasi dibuat',
              actionText: 'Masuk kembali',
              onAction: () {
                context.goNamed(RouteNames.login);
              },
            );
          },
        );
      });

      isLoading.value = true;
    }

    useEffect(() {
      getSchools();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: AppColor.light,
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: isLoading.value,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Daftar',
                            style: title24.copyWith(
                              color: AppColor.primary,
                            ),
                          ),
                          const AppPaddingSpacer(),
                          Text(
                            'Yuk, bikin akun untuk memulai.',
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
                            controller: nameController,
                            label: 'Nama',
                            prefix: const HeroIcon(HeroIcons.user),
                          ),
                          DropdownButtonFormField<String>(
                            hint: const Text('Pilih Sekolah'),
                            items: listOfSchool.value
                                .map<DropdownMenuItem<String>>((school) {
                              return DropdownMenuItem<String>(
                                value: school.id,
                                child: Text(school.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              getClasses(value);
                            },
                          ),
                          DropdownButtonFormField<String>(
                            hint: const Text('Pilih Kelas'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Tidak boleh kosong';
                              }
                              return null;
                            },
                            items: listOfClass.value
                                .map<DropdownMenuItem<String>>((classes) {
                              return DropdownMenuItem<String>(
                                value: classes.id,
                                child: Text(classes.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              selectedClassId.value = value;
                            },
                          ),
                          const AppPaddingSpacer(),
                          AppCustomInput(
                            controller: passwordController,
                            cannotEmpty: true,
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
                          AppCustomInput(
                            controller: confPasswordController,
                            cannotEmpty: true,
                            label: 'Ulangi Password',
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
                                register();
                              }
                            },
                            color: AppColor.primary,
                            text: Text(
                              'Daftar',
                              style: semibold16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Sudah punya akun? Yuk ',
                      style: semibold16.copyWith(
                        color: AppColor.base,
                      ),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              context.go('/login');
                            },
                            child: Text(
                              'Masuk',
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
      ),
    );
  }
}
