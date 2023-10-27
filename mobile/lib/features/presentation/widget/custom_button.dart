import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../../core/const/color.dart';

class AppCustomButton extends StatelessWidget {
  final Color color;
  final Widget text;
  final HeroIcons? icon;
  final Function()? onPressed;
  final bool disabled;
  final bool zeroPadding;
  const AppCustomButton({
    super.key,
    required this.color,
    required this.text,
    this.icon,
    this.onPressed,
    this.disabled = false,
    this.zeroPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: disabled ? () {} : onPressed,
      padding: zeroPadding
          ? const EdgeInsets.all(0)
          : const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
      minWidth: MediaQuery.of(context).size.width,
      textColor: disabled ? AppColor.base.withOpacity(.6) : Colors.white,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      color: disabled ? AppColor.base.withOpacity(.2) : color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          text,
          if (icon != null) const SizedBox(width: 4),
          if (icon != null) HeroIcon(icon!, size: 16)
        ],
      ),
    );
  }
}
