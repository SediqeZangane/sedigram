import 'package:flutter/material.dart';
import 'package:sedigram/login/presentation/login_screen.dart';
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
      theme: ThemeData(
        textTheme: textTheme,
        colorScheme: colorScheme,
      ),
      home: const LoginScreen(),
    );
  }
}
