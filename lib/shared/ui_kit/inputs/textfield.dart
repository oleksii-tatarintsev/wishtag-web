import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/shared/styles.dart';

class AppTextField extends StatelessWidget {
  final String title;
  final String? placeHolder;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  const AppTextField({
    required this.title,
    this.placeHolder,
    this.obscureText = false,
    this.controller,
    this.autovalidateMode,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.inputFormatters,
    this.autofillHints,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        spacing: 5.sp,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.regular18,
          ),
          TextFormField(
            enabled: enabled,
            obscureText: obscureText,
            controller: controller,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            autofillHints: autofillHints,
            autovalidateMode: autovalidateMode,
            validator: validator,
            decoration: InputDecoration(
              labelText: placeHolder,
              labelStyle: TextStyle(color: AppColors.inputStyleColor),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.inputStyleColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.blueButton,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.redButton,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.redButton,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.inputStyleColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
