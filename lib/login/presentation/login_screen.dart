import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/auth/application/auth_bloc.dart';
import 'package:sedigram/auth/application/auth_event.dart';
import 'package:sedigram/auth/application/auth_state.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/core/presentation/widget/form_text_field.dart';
import 'package:sedigram/core/presentation/widget/have_account_button.dart';
import 'package:sedigram/core/presentation/widget/primary_button.dart';
import 'package:sedigram/core/presentation/widget/text_separator_widget.dart';
import 'package:sedigram/home/presentation/home_screen.dart';
import 'package:sedigram/sign_up/presentation/sign_up_screen.dart';
import 'package:sedigram/theme/presentation/dimens.dart';

class LoginScreen extends StatefulWidget {
  static const String routeNamed = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (p, c) => p.loginResult != c.loginResult,
      listener: (_, state) {
        if (state.loginResult == LoginResult.succeed) {
          Navigator.pushNamed(context, HomeScreen.routeNamed);
        }
        if (state.loginResult == LoginResult.failed) {
          const showSnackBar = SnackBar(
            content: Text('Log in failed'),
          );
          ScaffoldMessenger.of(context).showSnackBar(showSnackBar);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: Dimens.large),
                  child: Text(
                    context.localization.appName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: Dimens.xxLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.medium,
                    vertical: Dimens.smallX,
                  ),
                  child: FormTextField(
                    hintText: context.localization.emailTextField,
                    textEditingController: emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.medium,
                    vertical: Dimens.smallX,
                  ),
                  child: FormTextField(
                    hintText: context.localization.passwordTextField,
                    textEditingController: passwordController,
                  ),
                ),
                forgetPassWidget(context),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimens.medium),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return PrimaryButton(
                          buttonName: context.localization.loginCTA,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  SubmitLoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          },
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: Dimens.xxLarge),
                const TextSeparatorWidget(),
                const SizedBox(height: Dimens.xxLarge),
                HaveAccountButton(
                  description: context.localization.doNotHaveAccount,
                  link: context.localization.signUpCTA,
                  onClick: () {
                    Navigator.pushNamed(context, SignUpScreen.routeNamed);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget forgetPassWidget(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.large,
          horizontal: Dimens.medium,
        ),
        child: GestureDetector(
          child: Text(
            context.localization.forgetPasswordText,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
