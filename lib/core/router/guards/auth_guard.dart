import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishtag_web/core/router/router.gr.dart';
import 'package:wishtag_web/presentation/login_screen/login_notifier.dart';

class AuthGuard extends AutoRouteGuard {
  final ProviderContainer container;

  AuthGuard(this.container);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final loginState = container.read(loginNotifierProvider);

    if (loginState.hasValue && loginState.value != null) {
      resolver.next(true);
    } else {
      router.push(LoginRoute()).then((_) {
        final updatedState = container.read(loginNotifierProvider);
        resolver.next(updatedState.hasValue && updatedState.value != null);
      });
    }
  }
}
