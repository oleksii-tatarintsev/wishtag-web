import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/shared/data_mock.dart';
import 'package:wishtag_web/shared/styles.dart';
import 'package:wishtag_web/shared/ui_kit.dart';

@RoutePage(name: 'DashboardRoute')
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWrapper(
      title: 'Admin Dashboard',
      children: [
        Row(
          children: [
            Row(
              spacing: 20.r,
              children: [
                ContainerInfo(
                  title: 'Total Users',
                  value: '1,245',
                  color: ContainerColor.red,
                ),
                ContainerInfo(
                  title: 'Wishlists Created',
                  value: '5,678',
                  color: ContainerColor.blue,
                ),
                ContainerInfo(
                  title: 'Active Tickets',
                  value: '12',
                  color: ContainerColor.orange,
                ),
              ],
            ),
          ],
        ),
        Text('Recent Activities', style: AppFonts.bold20),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: 40.r,
              top: 10.r,
              bottom: 40.r,
            ),
            padding: EdgeInsets.all(20.r),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.containerBorder,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: AppColors.mainBg),
            child: ListView.builder(
              itemCount: DataMock.recentActivities.length,
              itemBuilder: (BuildContext context, int index) => Text(DataMock.recentActivities[index]),
            ),
          ),
        ),
      ],
    );
  }
}
