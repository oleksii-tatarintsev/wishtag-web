import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/shared/styles.dart';

class ContentWrapper extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ContentWrapper({required this.title, required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainBg,
      child: Expanded(
        child: Container(
          margin: EdgeInsets.all(30.r),
          padding: EdgeInsets.only(
            top: 6.r,
            left: 20.r,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AppColors.containerBorder,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppFonts.title),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
