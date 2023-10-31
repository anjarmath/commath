import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/domain/entity/company_entity.dart';
import 'package:commath/features/presentation/riverpod/select_topic_provider.dart';
import 'package:commath/features/presentation/router/route_name.dart';
import 'package:commath/features/presentation/widget/app_spacer.dart';
import 'package:commath/features/presentation/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompanyProblemScreen extends ConsumerWidget {
  final CompanyEntity company;
  const CompanyProblemScreen({super.key, required this.company});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topic = ref.watch(selectTopicProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Tes',
          style: title20,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(20),
        child: AppCustomButton(
          onPressed: () {
            context.pushNamed(RouteNames.exam);
          },
          color: AppColor.primary,
          text: const Text("Kerjakan Soal"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppPaddingSpacer(),
            Text(
              'Instansi',
              style: semibold14,
            ),
            Text(
              company.name,
              style: title16,
            ),
            const AppPaddingSpacer(),
            Text(
              'Topic',
              style: semibold14,
            ),
            Text(
              topic!.name,
              style: title16,
            ),
            const AppPaddingSpacer(),
            Text(
              'Permasalahan',
              style: title18,
            ),
            Text(
              company.problem,
              style: regular14.copyWith(color: AppColor.base),
            ),
          ],
        ),
      ),
    );
  }
}
