import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:wishtag_web/core/environment.dart';

import 'internal/application.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  await Environment.instance.firebaseInit().whenComplete(
        () => runApp(
          Application(),
        ),
      );
}
