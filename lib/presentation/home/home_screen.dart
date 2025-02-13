import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wishtag_web/core/router/router.gr.dart';
import 'package:wishtag_web/presentation/auth/auth_notifier.dart';
import 'package:wishtag_web/presentation/home/widgets/navigation_bar_item.dart';
import 'package:wishtag_web/shared/styles.dart';

@RoutePage(name: 'HomeRoute')
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ValueNotifier<String> currentRoute = ValueNotifier('');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration.zero, () {
        if (!mounted) return;
        currentRoute.value = AutoRouter.of(context).currentPath;
      });
    });
    if (AutoRouter.of(context).currentPath == '/') {
      AutoRouter.of(context).push(DashboardRoute());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: 220.r,
                  color: AppColors.sideBarColor,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 15.r,
                      right: 15.r,
                      bottom: 15.r,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200.r,
                          height: 60.r,
                          child: Row(spacing: 10, children: [
                            SvgPicture.asset(
                              AppIcons.boxHeart,
                              width: 28.r,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            Text(
                              'WishTag',
                              style: AppFonts.bold28.copyWith(color: Colors.white),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 30.r,
                        ),
                        ValueListenableBuilder(
                          valueListenable: currentRoute,
                          builder: (context, value, child) {
                            return NavigationBarItem(
                              title: 'Dashboard',
                              icon: AppIcons.dashboardPanel,
                              route: DashboardRoute(),
                              isActiveTab: value == '/dashboard',
                              onNavigate: () {
                                currentRoute.value = '/dashboard';
                              },
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: currentRoute,
                          builder: (context, value, child) {
                            return NavigationBarItem(
                              title: 'Users',
                              icon: AppIcons.usersAlt,
                              route: UserGridRoute(),
                              isActiveTab: value == '/users',
                              onNavigate: () {
                                currentRoute.value = '/users';
                              },
                            );
                          },
                        ),
                        // ValueListenableBuilder(
                        //   valueListenable: currentRoute,
                        //   builder: (context, value, child) {
                        //     return NavigationBarItem(
                        //       title: 'Logs',
                        //       icon: AppIcons.newspaper,
                        //       route: UserGridRoute(),
                        //       isActiveTab: value == '/logs',
                        //       onNavigate: () {
                        //         currentRoute.value = '/logs';
                        //       },
                        //     );
                        //   },
                        // ),
                        // ValueListenableBuilder(
                        //   valueListenable: currentRoute,
                        //   builder: (context, value, child) {
                        //     return NavigationBarItem(
                        //       title: 'Administrators',
                        //       icon: AppIcons.adminAlt,
                        //       route: UserGridRoute(),
                        //       isActiveTab: value == '/administrators',
                        //       onNavigate: () {
                        //         currentRoute.value = '/administrators';
                        //       },
                        //     );
                        //   },
                        // ),
                        // ValueListenableBuilder(
                        //   valueListenable: currentRoute,
                        //   builder: (context, value, child) {
                        //     return NavigationBarItem(
                        //       title: 'Support',
                        //       icon: AppIcons.userHeadset,
                        //       route: UserGridRoute(),
                        //       isActiveTab: value == '/support',
                        //       onNavigate: () {
                        //         Future.delayed(Duration.zero, () {
                        //           currentRoute.value = '/support';
                        //         });
                        //       },
                        //     );
                        //   },
                        // ),
                        Spacer(),
                        Center(
                          child: MaterialButton(
                            mouseCursor: SystemMouseCursors.click,
                            height: 50,
                            minWidth: 50,
                            color: AppColors.redButton,
                            onPressed: () {
                              final loginNotifier = ref.read(authNotifierProvider.notifier);
                              loginNotifier.signOut();
                              AutoRouter.of(context).push(LoginRoute());
                            },
                            child: SvgPicture.asset(
                              AppIcons.logout,
                              colorFilter: ColorFilter.mode(AppColors.mainBg, BlendMode.srcIn),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: AutoRouter(),
          ),
        ],
      ),
    );
  }
}
