import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:wishtag_web/core/router/guards/auth_guard.dart';
import 'package:wishtag_web/core/router/router.gr.dart';
import 'package:wishtag_web/main.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
    durationInMilliseconds: 600,
    reverseDurationInMilliseconds: 600,
    transitionsBuilder: (_, anim, __, child) {
      return FadeTransition(opacity: anim, child: child);
    },
  );

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(
      path: '/',
      page: HomeRoute.page,
      initial: true,
      guards: [AuthGuard(globalAuthContainer)],
      children: [
        AutoRoute(path: 'dashboard', page: DashboardRoute.page),
        AutoRoute(
          path: 'users',
          page: UsersRootRoute.page,
          children: [
            AutoRoute(path: '', page: UserGridRoute.page, initial: true),
            AutoRoute(path: 'view', page: UserViewRoute.page),
            AutoRoute(path: 'wishlist', page: WishListViewRoute.page),
          ],
        ),
      ],
    ),
  ];
}
