import 'package:get/get.dart';
import 'package:trekkers_project/config/app_router.dart';
import 'package:trekkers_project/config/theme.dart';
import 'package:trekkers_project/screens/auth/Welcome/welcome_screen.dart';
import 'package:trekkers_project/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
          primaryColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        ),
         onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: WelcomeScreen.routeName,);
  }
}

