import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishtag_web/core/router/router.gr.dart';
import 'package:wishtag_web/presentation/auth/auth_notifier.dart';

class AuthGuard extends AutoRouteGuard {
  final ProviderContainer container;

  AuthGuard(this.container);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final loginState = container.read(authNotifierProvider);

    if (loginState.hasValue && loginState.value != null) {
      resolver.next(true);
    } else {
      router.push(LoginRoute()).then((_) {
        final updatedState = container.read(authNotifierProvider);
        resolver.next(updatedState.hasValue && updatedState.value != null);
      });
    }
  }
}
