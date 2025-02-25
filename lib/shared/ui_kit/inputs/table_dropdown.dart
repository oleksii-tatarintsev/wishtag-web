import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/shared/styles/colors.dart';
import 'package:wishtag_web/shared/styles/fonts.dart';

class TableDropDown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final TextEditingController controller;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String placeHolder;

  const TableDropDown({
    required this.controller,
    required this.onChanged,
    required this.items,
    required this.placeHolder,
    this.value,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      style: AppFonts.regular14.copyWith(color: AppColors.inputStyleColor),
      decoration: InputDecoration(
        labelText: placeHolder,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 10.r),
        labelStyle: AppFonts.regular14.copyWith(color: AppColors.inputStyleColor),
        isDense: true,
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.blueButton)),
      ),
    );
  }
}
