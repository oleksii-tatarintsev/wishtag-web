import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/core/router/router.dart';
import 'package:wishtag_web/shared/styles.dart';
import 'package:wishtag_web/utils/toast_messenger/toast_wrapper.dart';

class Application extends ConsumerWidget {
  Application({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToastWrapper(
      child: ScreenUtilInit(
        designSize: Size(1440, 900),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widget) {
          return ProviderScope(
            child: MaterialApp.router(
              title: 'WishTag App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.defaultTextColor),
                useMaterial3: true,
                fontFamily: 'Montserrat',
                textTheme: ThemeData.light().textTheme.apply(
                  fontFamily: 'Montserrat',
                  bodyColor: AppColors.defaultTextColor,
                  displayColor: AppColors.defaultTextColor,
                ),
              ),
              routerConfig: appRouter.config(),
            ),
          );
        },
      ),
    );
  }
}
