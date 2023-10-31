import 'package:flutter/material.dart';

class AppPaddingSpacer extends StatelessWidget {
  final double? width;
  final double? height;
  const AppPaddingSpacer({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 20,
      height: height ?? 20,
    );
  }
}
