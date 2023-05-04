import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sedigram/firebase_options.dart';
import 'package:sedigram/login/application/login_bloc.dart';
import 'package:sedigram/login/presentation/login_screen.dart';
import 'package:sedigram/sign_up/presentation/sign_up_screen.dart';
import 'package:sedigram/theme/presentation/color_scheme.dart';
import 'package:sedigram/theme/presentation/text_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: const LoginScreen(),
      ),
    );
  }
}
