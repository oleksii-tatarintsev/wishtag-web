import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:wishtag_web/core/environment.dart';
//import 'internal/application.dart';

final globalAuthContainer = ProviderContainer();

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  await Environment.instance.firebaseInit().whenComplete(
    () => runApp(UncontrolledProviderScope(container: globalAuthContainer, child: Application())),
  );
}
