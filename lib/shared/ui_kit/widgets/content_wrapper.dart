import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/shared/styles.dart';

class ContentWrapper extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final List<Widget>? actions;
  final bool showBackButton;
  const ContentWrapper({
    required this.title,
    required this.children,
    this.showBackButton = false,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainBg,
      child: Container(
        margin: EdgeInsets.all(30.r),
        padding: EdgeInsets.only(top: 6.r, left: 20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.containerBorder, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (showBackButton)
                  IconButton(
                    onPressed: () => context.router.removeLast(),
                    icon: Icon(Icons.arrow_back_rounded, color: AppColors.sideBarColor),
                  ),
                Text(title, style: AppFonts.title),
                Spacer(),
                ...actions ?? [SizedBox.shrink()],
              ],
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
