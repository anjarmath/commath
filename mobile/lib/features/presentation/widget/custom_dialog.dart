import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/presentation/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:lottie/lottie.dart';

enum AlertHeaderType {
  defaultWithIcon,
  success,
  failed,
}

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    required this.message,
    required this.actionText,
    this.onAction,
    this.alertHeaderType = AlertHeaderType.defaultWithIcon,
    this.icon = HeroIcons.exclamationCircle,
    this.iconColor = Colors.black,
    this.actionColor,
  });
  final AlertHeaderType alertHeaderType;
  final HeroIcons icon;
  final Color iconColor;
  final Color? actionColor;
  final String message;
  final String actionText;
  final Function()? onAction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      icon: _makeHeader(context),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: regular14.copyWith(color: AppColor.black),
          ),
        ],
      ),
      actions: [
        AppCustomButton(
          onPressed: onAction,
          text: Text(
            actionText,
            style: regular12_5.copyWith(
              color: Colors.white,
            ),
          ),
          color: actionColor ?? AppColor.black,
        )
      ],
    );
  }

  Widget _makeHeader(BuildContext context) {
    switch (alertHeaderType) {
      case AlertHeaderType.defaultWithIcon:
        return HeroIcon(
          icon,
          color: iconColor,
        );
      case AlertHeaderType.success:
        return SizedBox(
          height: 82,
          child: LottieBuilder.asset(
            'assets/lottie/success.json',
            fit: BoxFit.fitHeight,
            repeat: true,
          ),
        );
      case AlertHeaderType.failed:
        return SizedBox(
          height: 72,
          child: LottieBuilder.asset(
            'assets/lottie/error.json',
            fit: BoxFit.fitHeight,
            repeat: true,
          ),
        );
    }
  }
}

class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    this.onConfirm,
    required this.cancelText,
    this.onCancel,
    this.danger = false,
    this.alertHeaderType = AlertHeaderType.defaultWithIcon,
    this.icon = HeroIcons.exclamationCircle,
    this.iconColor = Colors.black,
    this.confirmColor,
  });

  final AlertHeaderType alertHeaderType;
  final HeroIcons icon;
  final Color iconColor;
  final Color? confirmColor;
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final bool danger;
  final Function()? onConfirm;
  final Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      icon: _makeHeader(context),
      title: Text(
        title,
        style: bold18.copyWith(
          color: AppColor.black,
        ),
      ),
      content: Text(
        message,
        style: regular14.copyWith(
          color: AppColor.base,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            cancelText,
            style: semibold16.copyWith(
              color: AppColor.primary,
            ),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            confirmText,
            style: semibold16.copyWith(
              color: danger ? AppColor.error : AppColor.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _makeHeader(BuildContext context) {
    switch (alertHeaderType) {
      case AlertHeaderType.defaultWithIcon:
        return HeroIcon(
          icon,
          color: iconColor,
        );
      case AlertHeaderType.success:
        return SizedBox(
          height: 82,
          child: LottieBuilder.asset(
            'assets/lottie/success.json',
            fit: BoxFit.fitHeight,
            repeat: true,
          ),
        );
      case AlertHeaderType.failed:
        return SizedBox(
          height: 72,
          child: LottieBuilder.asset(
            'assets/lottie/error.json',
            fit: BoxFit.fitHeight,
            repeat: true,
          ),
        );
    }
  }
}
