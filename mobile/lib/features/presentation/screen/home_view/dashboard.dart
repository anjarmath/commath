import 'package:commath/dependency_injection.dart';
import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/core/state/notifier_state.dart';
import 'package:commath/features/domain/repository/auth_repo.dart';
import 'package:commath/features/presentation/riverpod/get_company_provider.dart';
import 'package:commath/features/presentation/riverpod/get_user_data_provider.dart';
import 'package:commath/features/presentation/screen/company_view.dart';
import 'package:commath/features/presentation/widget/app_spacer.dart';
import 'package:commath/features/presentation/widget/custom_button.dart';
import 'package:commath/features/presentation/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataNotifierProvider);
    final companies = ref.watch(getCompanyNotifierProvider);
    void actLogout() {
      showDialog(
        context: context,
        builder: (context) {
          return AppConfirmationDialog(
            title: 'Perhatian',
            message: 'Yakin ingin keluar dari akun?',
            confirmText: 'Ya',
            confirmColor: AppColor.error,
            cancelText: 'Tidak',
            onCancel: () {
              Navigator.pop(context);
            },
            onConfirm: () {
              sl<AuthRepository>().logout();
              ref.read(userDataNotifierProvider.notifier).reset();
              context.go('/invalid');
            },
          );
        },
      );
    }

    final popupList = <MyPopupMenu>[
      MyPopupMenu(
        label: 'Logout',
        color: AppColor.error,
        onClick: actLogout,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColor.light,
      appBar: AppBar(
        backgroundColor: AppColor.light,
        elevation: 0,
        toolbarHeight: kToolbarHeight + 42,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang kembali',
              style: semibold16.copyWith(
                color: AppColor.base,
              ),
            ),
            Skeletonizer(
              enabled: user.loading && user.state == NotifierState.initial,
              child: Text(
                user.data.name,
                style: title20.copyWith(
                  color: AppColor.black,
                ),
              ),
            )
          ],
        ),
        actions: [
          DashboardPopup(popupList: popupList),
          const AppPaddingSpacer(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          user.initUser();
          companies.getCompany();
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              color: AppColor.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total poin kamu:',
                      style: title16.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                    const AppPaddingSpacer(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          user.data.stars.toString(),
                          style: title24.copyWith(
                            color: AppColor.white,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Poin',
                          style: semibold14.copyWith(
                            color: AppColor.white,
                          ),
                        )
                      ],
                    ),
                    const AppPaddingSpacer(),
                    AppCustomButton(
                      onPressed: () {},
                      color: AppColor.lightBlue,
                      text: const Text('Kerjakan tes lagi'),
                      icon: HeroIcons.arrowRight,
                    )
                  ],
                ),
              ),
            ),
            const AppPaddingSpacer(),
            Text(
              'Pilihan Instansi',
              style: title16,
            ),
            const AppPaddingSpacer(),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: AppColor.white,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CompanyViewProfileScreen(
                                  company: companies.company[index],
                                  showToProblem: false,
                                )));
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColor.secondary.withOpacity(.2)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: SizedBox(
                    width: 42,
                    child: Image.network(
                      companies.company[index].profile,
                      errorBuilder: (context, error, stackTrace) {
                        return const Placeholder();
                      },
                    ),
                  ),
                  title: Text(
                    companies.company[index].name,
                    style: title16,
                  ),
                  subtitle: const Text('Instansi'),
                  trailing: Text(
                    'lihat',
                    style: regular14.copyWith(color: AppColor.secondary),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20);
              },
              itemCount: companies.company.length,
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardPopup extends StatelessWidget {
  const DashboardPopup({
    super.key,
    required this.popupList,
  });

  final List<MyPopupMenu> popupList;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MyPopupMenu>(
      position: PopupMenuPosition.under,
      padding: const EdgeInsets.all(0),
      onSelected: (item) {
        item.onClick();
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MyPopupMenu>>[
        for (var item in popupList)
          PopupMenuItem(
            value: item,
            child: Text(
              item.label,
              style: regular14.copyWith(color: item.color),
            ),
          ),
      ],
      icon: Image.asset(
        'assets/images/pp.png',
        width: 52,
      ),
    );
  }
}

class MyPopupMenu {
  final String label;
  final Color color;
  final Function() onClick;

  const MyPopupMenu({
    required this.label,
    required this.color,
    required this.onClick,
  });
}
