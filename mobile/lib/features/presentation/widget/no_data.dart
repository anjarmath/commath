import 'package:commath/features/core/const/color.dart';
import 'package:commath/features/core/const/typography.dart';
import 'package:commath/features/presentation/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    this.message,
    this.title,
    this.onRetry,
  });
  final String? title;
  final String? message;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/unknown.svg'),
            const SizedBox(height: 12),
            Text(
              title ?? 'Oops! Tidak ada data!',
              style: bold18.copyWith(
                color: AppColor.primary,
              ),
            ),
            const SizedBox(height: 12),
            message != null
                ? Text(
                    message!,
                    style: regular14.copyWith(
                      color: AppColor.base,
                    ),
                  )
                : Container(),
            const SizedBox(height: 12),
            if (onRetry != null)
              AppCustomButton(
                color: AppColor.primary,
                text: const Text('Coba Lagi'),
                onPressed: onRetry,
              )
          ],
        ),
      ),
    );
  }
}
