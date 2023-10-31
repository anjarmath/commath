import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/core/state/notifier_state.dart';
import 'package:commath/features/presentation/riverpod/get_topic_provider.dart';
import 'package:commath/features/presentation/riverpod/select_topic_provider.dart';
import 'package:commath/features/presentation/router/route_name.dart';
import 'package:commath/features/presentation/widget/app_spacer.dart';
import 'package:commath/features/presentation/widget/loading_overlay.dart';
import 'package:commath/features/presentation/widget/no_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectTopicScreen extends ConsumerWidget {
  const SelectTopicScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topic = ref.watch(getTopicNotifierProvider);
    return Scaffold(
      backgroundColor: AppColor.light,
      appBar: AppBar(
        title: Text(
          'Pilih Topik',
          style: title20,
        ),
      ),
      body: LoadingOverlay(
        isLoading: topic.loading,
        child: RefreshIndicator(
          onRefresh: () async {
            topic.getTopic();
          },
          child: topic.state == NotifierState.initial
              ? const NoData()
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: AppColor.white,
                      onTap: () {
                        ref
                            .read(selectTopicProvider.notifier)
                            .update((state) => topic.topic[index]);
                        context.pushNamed(RouteNames.selectCompany);
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColor.secondary.withOpacity(.3),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text(topic.topic[index].name),
                      trailing: HeroIcon(HeroIcons.chevronRight,
                          color: AppColor.secondary),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const AppPaddingSpacer(
                      height: 12,
                    );
                  },
                  itemCount: topic.topic.length,
                ),
        ),
      ),
    );
  }
}
