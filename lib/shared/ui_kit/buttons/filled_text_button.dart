import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/shared/styles.dart';

enum FilledTextButtonType { red, green, blue }

extension on FilledTextButtonType {
  Color get color {
    switch (this) {
      case FilledTextButtonType.red:
        return AppColors.redButton;
      case FilledTextButtonType.green:
        return AppColors.greenButton;
      case FilledTextButtonType.blue:
        return AppColors.blueButton;
    }
  }
}

class AppFilledTextButton extends StatelessWidget {
  final String title;
  final FilledTextButtonType buttonStyle;
  final VoidCallback? onPressed;
  const AppFilledTextButton({
    required this.title,
    required this.buttonStyle,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        height: 50.sp,
        color: buttonStyle.color,
        disabledColor: buttonStyle.color.withValues(alpha: 0.5),
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(title, style: AppFonts.regular18),
      ),
    );
  }
}
