import 'package:commath/dependency_injection.dart';
import 'package:commath/features/domain/repository/auth_repo.dart';
import 'package:commath/features/presentation/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void invalidSessionHandler(BuildContext context) {
  sl<AuthRepository>().logout();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AppAlertDialog(
        onAction: () {
          context.go('/invalid');
        },
        actionText: 'Login Kembali',
        message: 'Maaf, Sesi Anda telah berakhir!',
      );
    },
  );
}
