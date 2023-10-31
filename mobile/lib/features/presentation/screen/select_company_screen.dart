import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/core/state/notifier_state.dart';
import 'package:commath/features/presentation/riverpod/get_company_provider.dart';
import 'package:commath/features/presentation/riverpod/select_company_provider.dart';
import 'package:commath/features/presentation/screen/company_view.dart';
import 'package:commath/features/presentation/widget/app_spacer.dart';
import 'package:commath/features/presentation/widget/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widget/no_data.dart';

class SelectCompanyScreen extends ConsumerWidget {
  const SelectCompanyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companies = ref.watch(getCompanyNotifierProvider);
    return Scaffold(
      backgroundColor: AppColor.light,
      appBar: AppBar(
        title: Text(
          'Pilih Instansi',
          style: title20,
        ),
      ),
      body: LoadingOverlay(
        isLoading: companies.loading,
        child: RefreshIndicator(
          onRefresh: () async {
            companies.getCompany();
          },
          child: companies.state == NotifierState.initial
              ? const NoData()
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: AppColor.white,
                      onTap: () {
                        ref
                            .read(selectCompanyProvider.notifier)
                            .update((state) => companies.company[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CompanyViewProfileScreen(
                                    company: companies.company[index])));
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: AppColor.secondary.withOpacity(.2)),
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
                      trailing: HeroIcon(HeroIcons.chevronRight,
                          color: AppColor.secondary),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const AppPaddingSpacer(
                      height: 12,
                    );
                  },
                  itemCount: companies.company.length,
                ),
        ),
      ),
    );
  }
}
