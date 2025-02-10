import 'package:flutter/material.dart';
import 'package:wishtag_web/core/environment.dart';

import 'internal/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Environment.instance.firebaseInit().whenComplete(
        () => runApp(
          Application(),
        ),
      );
}
