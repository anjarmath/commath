import 'package:commath/dependency_injection.dart';
import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/domain/entity/exam_entity.dart';
import 'package:commath/features/domain/repository/exam_repo.dart';
import 'package:commath/features/presentation/riverpod/select_company_provider.dart';
import 'package:commath/features/presentation/router/route_name.dart';
import 'package:commath/features/presentation/widget/app_spacer.dart';
import 'package:commath/features/presentation/widget/custom_button.dart';
import 'package:commath/features/presentation/widget/custom_dialog.dart';
import 'package:commath/features/presentation/widget/loading_overlay.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExamScreen extends HookConsumerWidget {
  const ExamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final company = ref.watch(selectCompanyProvider);

    final isLoading = useState<bool>(false);
    final exam = useState<ExamEntity>(
      const ExamEntity(id: '', company_id: '', topic_id: '', question: ''),
    );

    final step = useState<int>(1);

    final diketahuiController = useTextEditingController(text: '');
    final ditanyaController = useTextEditingController(text: '');
    final jawabController = useTextEditingController(text: '');
    final kesimpulanController = useTextEditingController(text: '');

    Future<void> getExam() async {
      isLoading.value = true;

      final res = await sl<ExamRepository>().getCompanyExam(company!.id);
      res.fold(
        (l) {
          showDialog(
            context: context,
            builder: (context) {
              return AppAlertDialog(
                message: l.getMessage(),
                actionText: 'Kembali',
                onAction: () {
                  context.pop();
                  context.pop();
                },
              );
            },
          );
        },
        (r) => exam.value = r,
      );

      isLoading.value = false;
    }

    void previous() {
      if (step.value == 1) {
        return;
      }

      step.value--;
    }

    void next() {
      if (step.value == 4) {
        return;
      }

      step.value++;
    }

    Future<void> sendAnswer() async {
      isLoading.value = true;

      final res = await sl<ExamRepository>().submitAnswer(
        examId: exam.value.id,
        diketahui: diketahuiController.text,
        ditanya: ditanyaController.text,
        jawab: jawabController.text,
        kesimpulan: kesimpulanController.text,
      );

      res.fold(
        (l) {
          context.showErrorBar(content: Text(l.getMessage()));
        },
        (r) {
          showDialog(
            context: context,
            builder: (context) {
              return AppConfirmationDialog(
                alertHeaderType: AlertHeaderType.success,
                title: 'Yeay! jawaban berhasil dikirim',
                message: 'Ingin mengerjakan lagi?',
                confirmText: 'Ya',
                cancelText: 'Tidak',
                onCancel: () {
                  context.pop();
                  context.pop();
                  context.goNamed(RouteNames.root);
                },
                onConfirm: () {
                  context.pop();
                  context.pop();
                  context.goNamed(RouteNames.exam);
                },
              );
            },
          );
        },
      );

      isLoading.value = false;
    }

    Future<void> sendAnswerConfirm() async {
      showDialog(
        context: context,
        builder: (context) {
          return AppConfirmationDialog(
            title: 'Perhatian',
            message: 'Yakin ingin mengirim jawaban sekarang?',
            confirmText: 'Ya',
            cancelText: 'Tidak',
            onConfirm: () async {
              context.pop();

              await sendAnswer();
            },
            onCancel: () {
              context.pop();
            },
          );
        },
      );
    }

    useEffect(() {
      getExam();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Tes',
          style: title20,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          children: [
            Flexible(
              child: AppCustomButton(
                onPressed: () {
                  previous();
                },
                color: AppColor.secondary,
                text: const Text('Sebelumnya'),
              ),
            ),
            const AppPaddingSpacer(),
            Flexible(
              child: AppCustomButton(
                onPressed: () {
                  step.value == 4 ? sendAnswerConfirm() : next();
                },
                color: AppColor.primary,
                text: Text(step.value == 4 ? 'Kirim' : 'Selanjutnya'),
              ),
            ),
          ],
        ),
      ),
      body: LoadingOverlay(
        isLoading: isLoading.value,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Soal',
                      style: title18,
                    ),
                    Text(
                      exam.value.question,
                      style: regular14.copyWith(color: AppColor.base),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Divider(
                      color: AppColor.secondary,
                      thickness: 1.5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 1; i <= 4; i++)
                        Container(
                          width: 38,
                          height: 38,
                          margin: const EdgeInsets.only(bottom: 19, top: 19),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: step.value >= i
                                  ? AppColor.secondary
                                  : AppColor.white,
                              borderRadius: BorderRadius.circular(200),
                              border: Border.all(color: AppColor.secondary)),
                          child: Center(
                            child: Text(
                              i.toString(),
                              style: bold16.copyWith(
                                color: step.value >= i
                                    ? AppColor.white
                                    : AppColor.secondary,
                              ),
                            ),
                          ),
                        )
                    ],
                  )
                ],
              ),
              Visibility(
                visible: step.value == 1,
                child: Expanded(
                  child: TextField(
                    controller: diketahuiController,
                    decoration: const InputDecoration(
                      labelText: 'Diketahui',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                  ),
                ),
              ),
              Visibility(
                visible: step.value == 2,
                child: Expanded(
                  child: TextField(
                    controller: ditanyaController,
                    decoration: const InputDecoration(
                      labelText: 'Ditanya',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                  ),
                ),
              ),
              Visibility(
                visible: step.value == 3,
                child: Expanded(
                  child: TextField(
                    controller: jawabController,
                    decoration: const InputDecoration(
                      labelText: 'Jawab',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                  ),
                ),
              ),
              Visibility(
                visible: step.value == 4,
                child: Expanded(
                  child: TextField(
                    controller: kesimpulanController,
                    decoration: const InputDecoration(
                      labelText: 'Kesimpulan',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
