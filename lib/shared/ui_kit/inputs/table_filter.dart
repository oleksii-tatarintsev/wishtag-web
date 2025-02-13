import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/shared/styles.dart';

class TableFilter extends StatelessWidget {
  final String? placeHolder;
  final TextEditingController? controller;
  final ValueChanged<String?>? onChanged;

  const TableFilter({
    this.placeHolder,
    this.controller,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.r),
      child: TextField(
        style: AppFonts.regular14.copyWith(color: AppColors.inputStyleColor),
        enableSuggestions: true,
        controller: controller,
        onChanged: onChanged,
        cursorHeight: 14.r,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 10.r),
          labelText: placeHolder,
          labelStyle: AppFonts.regular14.copyWith(color: AppColors.inputStyleColor),
          isDense: true,
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
        ),
      ),
    );
  }
}
