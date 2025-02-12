import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wishtag_web/core/router/router.gr.dart';
import 'package:wishtag_web/presentation/home_screen/widgets/navigation_bar_item.dart';
import 'package:wishtag_web/presentation/login_screen/login_notifier.dart';
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
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration.zero, () {
        if (!mounted) return;
        currentRoute.value = AutoRouter.of(context).currentPath;
      });
    });

    AutoRouter.of(context).push(DashboardRoute());
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
                  width: 220.sp,
                  color: AppColors.sideBarColor,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.sp, right: 15.sp, bottom: 15.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200.sp,
                          height: 60.sp,
                          child: Row(spacing: 10, children: [
                            SvgPicture.asset(
                              'assets/icons/box-heart.svg',
                              width: 28.sp,
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
                          height: 30.sp,
                        ),
                        ValueListenableBuilder(
                            valueListenable: currentRoute,
                            builder: (context, value, child) {
                              return NavigationBarItem(
                                title: 'Dashboard',
                                icon: 'assets/icons/dashboard-panel.svg',
                                route: DashboardRoute(),
                                isActiveTab: value == '/dashboard',
                                onNavigate: () {
                                  currentRoute.value = '/dashboard';
                                },
                              );
                            }),
                        ValueListenableBuilder(
                            valueListenable: currentRoute,
                            builder: (context, value, child) {
                              return NavigationBarItem(
                                title: 'Users',
                                icon: 'assets/icons/users-alt.svg',
                                route: UsersRoute(),
                                isActiveTab: value == '/users',
                                onNavigate: () {
                                  currentRoute.value = '/users';
                                },
                              );
                            }),
                        ValueListenableBuilder(
                            valueListenable: currentRoute,
                            builder: (context, value, child) {
                              return NavigationBarItem(
                                title: 'Logs',
                                icon: 'assets/icons/newspaper.svg',
                                route: UsersRoute(),
                                isActiveTab: value == '/logs',
                                onNavigate: () {
                                  currentRoute.value = '/logs';
                                },
                              );
                            }),
                        ValueListenableBuilder(
                            valueListenable: currentRoute,
                            builder: (context, value, child) {
                              return NavigationBarItem(
                                title: 'Administrators',
                                icon: 'assets/icons/admin-alt.svg',
                                route: UsersRoute(),
                                isActiveTab: value == '/administrators',
                                onNavigate: () {
                                  currentRoute.value = '/administrators';
                                },
                              );
                            }),
                        ValueListenableBuilder(
                            valueListenable: currentRoute,
                            builder: (context, value, child) {
                              return NavigationBarItem(
                                title: 'Support',
                                icon: 'assets/icons/user-headset.svg',
                                route: UsersRoute(),
                                isActiveTab: value == '/support',
                                onNavigate: () {
                                  Future.delayed(Duration.zero, () {
                                    currentRoute.value = '/support';
                                  });
                                },
                              );
                            }),
                        Spacer(),
                        Center(
                          child: MaterialButton(
                            mouseCursor: SystemMouseCursors.click,
                            height: 50,
                            minWidth: 50,
                            color: AppColors.redButton,
                            onPressed: () {
                              final loginNotifier = ref.read(loginNotifierProvider.notifier);
                              loginNotifier.signOut();
                            },
                            child: SvgPicture.asset(
                              'assets/icons/logout.svg',
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
