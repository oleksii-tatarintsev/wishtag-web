import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/shared/styles.dart';

enum ContainerColor { red, blue, orange }

extension on ContainerColor {
  Color get color {
    switch (this) {
      case ContainerColor.red:
        return AppColors.redButton.withValues(alpha: 0.9);
      case ContainerColor.blue:
        return AppColors.blueButton.withValues(alpha: 0.9);
      case ContainerColor.orange:
        return AppColors.orange.withValues(alpha: 0.9);
    }
  }
}

class ContainerInfo extends StatelessWidget {
  final String title;
  final String value;
  final ContainerColor color;
  const ContainerInfo({required this.title, required this.value, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 18.r),
      decoration: BoxDecoration(color: color.color, borderRadius: BorderRadius.all(Radius.circular(12))),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.r),
      width: 250.r,
      height: 120.r,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppFonts.regular18.copyWith(color: Colors.white)),
          Text(value, style: AppFonts.title.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
