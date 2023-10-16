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
import 'package:sedigram/theme/presentation/dimens.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeNamed = 'signUp';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController repeatPasswordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.loginResult != current.loginResult,
      listener: (context, state) {
        if (state.loginResult == LoginResult.succeed) {
          Navigator.pushNamed(context, HomeScreen.routeNamed);
        }
        if (state.loginResult == LoginResult.signUpFailed) {
          const showSnackBar = SnackBar(
            content: Text('SignUp failed'),
          );
          ScaffoldMessenger.of(context).showSnackBar(showSnackBar);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.medium,
                    vertical: Dimens.smallX,
                  ),
                  child: FormTextField(
                    hintText: context.localization.repeatPasswordTextField,
                    textEditingController: repeatPasswordController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.medium,
                    vertical: Dimens.smallX,
                  ),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return PrimaryButton(
                          buttonName: context.localization.signUpCTA,
                          onPressed: () {
                            if (repeatPasswordController.text ==
                                passwordController.text) {
                              context.read<AuthBloc>().add(
                                    SubmitSignUpEvent(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                            } else {
                              const showSnackBar = SnackBar(
                                content: Text("password isn't match"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(showSnackBar);
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: Dimens.xxLarge,
                ),
                const TextSeparatorWidget(),
                const SizedBox(
                  height: Dimens.xxLarge,
                ),
                HaveAccountButton(
                  description: context.localization.haveAccount,
                  link: context.localization.loginCTA,
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
