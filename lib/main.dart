import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/core/environment.dart';
import 'package:wishtag_web/presentation/login_screen/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Environment.instance.firebaseInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return MaterialApp(
            title: 'WishTag App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: LoginScreen());
      },
    );
  }
}
