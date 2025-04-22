import 'package:flutter/material.dart';
import 'package:meetings/ui/core/theme/colors.dart';
import 'package:meetings/ui/landing_screen/widgets/landing_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFFF),
        colorScheme: ColorScheme.dark(
          primary: AppColor.p1
        )
      ),
      home: LandingScreen(),
    );
  }
}
