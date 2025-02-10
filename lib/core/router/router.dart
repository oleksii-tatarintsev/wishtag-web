import 'package:auto_route/auto_route.dart';
import 'package:wishtag_web/core/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/login', page: LoginRoute.page, initial: true),
      ];
}
