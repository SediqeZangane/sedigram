import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/auth/application/auth_bloc.dart';
import 'package:sedigram/auth/application/auth_state.dart';
import 'package:sedigram/home/presentation/home_screen.dart';
import 'package:sedigram/login/presentation/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeNamed = 'splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLogin) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeNamed);
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.routeNamed);
        }
      },
      child: ColoredBox(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            height: 80,
            child: Image.asset('assets/icon/sedigram_Icon.png'),
          ),
        ),
      ),
    );
  }
}
