import 'package:commath/features/core/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppCustomInput extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? suffix;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isObscure;
  final bool isNumeric;
  final bool includelabel;
  final bool cannotEmpty;
  final bool readOnly;
  final bool confortableDensity;

  const AppCustomInput({
    super.key,
    required this.label,
    this.hintText,
    this.isObscure = false,
    this.isNumeric = false,
    this.onChanged,
    this.validator,
    this.controller,
    this.prefix,
    this.suffix,
    this.includelabel = true,
    this.cannotEmpty = true,
    this.readOnly = false,
    this.confortableDensity = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            obscureText: isObscure,
            readOnly: readOnly,
            onChanged: onChanged,
            style: TextStyle(
              color: AppColor.primary,
            ),
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            inputFormatters: isNumeric
                ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                : <TextInputFormatter>[],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: label,
              hintText: hintText,
              filled: true,
              fillColor: readOnly ? AppColor.light : Colors.white,
              prefixIcon: prefix,
              prefixIconColor: AppColor.base,
              focusColor: AppColor.primary,
              suffixIconColor: Colors.red,
              suffixIcon: suffix,
              contentPadding: confortableDensity
                  ? null
                  : const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColor.primary,
              )),
              border: const UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.base.withOpacity(.3),
                ),
              ),
            ),
            validator: validator ??
                (value) {
                  if (cannotEmpty && (value == null || value.isEmpty)) {
                    return 'Tidak boleh kosong';
                  }
                  if (isNumeric &&
                      (value == null || value.isEmpty || value == '0')) {
                    return 'Tidak boleh diisi 0';
                  }
                  return null;
                },
          ),
        ],
      ),
    );
  }
}
