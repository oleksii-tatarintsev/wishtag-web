import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wishtag_web/shared/styles.dart';

class NavigationBarItem extends StatelessWidget {
  final String title;
  final String icon;
  final PageRouteInfo route;
  final bool isActiveTab;
  final VoidCallback onNavigate;

  const NavigationBarItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.isActiveTab,
    required this.onNavigate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.r),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            AutoRouter.of(context).push(route);
            onNavigate.call();
          },
          child: Row(
            spacing: 10.r,
            children: [
              SvgPicture.asset(icon, width: 18.r, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
              Text(
                title,
                style: AppFonts.regular18.copyWith(
                  color: Colors.white,
                  fontWeight: isActiveTab ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
