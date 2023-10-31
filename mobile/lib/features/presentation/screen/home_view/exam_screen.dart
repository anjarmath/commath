import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/core/state/notifier_state.dart';
import 'package:commath/features/presentation/controller/datetime_controller.dart';
import 'package:commath/features/presentation/riverpod/get_answer_provider.dart';
import 'package:commath/features/presentation/widget/loading_overlay.dart';
import 'package:commath/features/presentation/widget/no_data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExamView extends HookConsumerWidget {
  const ExamView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answer = ref.watch(getAnswerNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Tesmu',
          style: title20,
        ),
      ),
      body: LoadingOverlay(
        isLoading: answer.loading,
        child: RefreshIndicator(
          onRefresh: () async {
            answer.getAnswer();
          },
          child: answer.state == NotifierState.initial
              ? const NoData()
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: AppColor.secondary.withOpacity(.2)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      leading: Text(
                        DatetimeController.formatDatetime(
                          answer.answer[index].created_at,
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 6),
                        decoration: BoxDecoration(
                          color: answer.answer[index].feedback == null
                              ? AppColor.error
                              : AppColor.success,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Text(
                          answer.answer[index].feedback == null
                              ? 'Menunggu Review'
                              : 'Direview',
                          style: regular14.copyWith(color: AppColor.white),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                  itemCount: answer.answer.length,
                ),
        ),
      ),
    );
  }
}
