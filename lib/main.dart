import 'package:flutter/material.dart';
import 'package:sedigram/login/presentation/login_screen.dart';
import 'package:sedigram/sign_up/presentation/sign_up_screen.dart';
import 'package:sedigram/theme/presentation/color_scheme.dart';
import 'package:sedigram/theme/presentation/text_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        LoginScreen.routeNamed: (context) => const LoginScreen(),
        SignUpScreen.routeNamed: (context) => const SignUpScreen(),
      },
      theme: ThemeData(
        textTheme: textTheme,
        colorScheme: colorScheme,
        fontFamily: 'SFPro',
      ),
      home: const LoginScreen(),
    );
  }
}
