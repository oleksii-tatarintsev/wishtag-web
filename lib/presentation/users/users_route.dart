import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'UsersRootRoute')
class UserRoute extends StatelessWidget {
  const UserRoute({super.key});

  @override
  AutoRouter build(BuildContext context) {
    return AutoRouter();
  }
}
