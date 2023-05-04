import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/core/presentation/widget/form_text_field.dart';
import 'package:sedigram/core/presentation/widget/have_account_button.dart';
import 'package:sedigram/core/presentation/widget/primary_button.dart';
import 'package:sedigram/core/presentation/widget/text_separator_widget.dart';
import 'package:sedigram/theme/presentation/dimens.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeNamed = 'signUp';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.medium,
                  vertical: Dimens.smallX,
                ),
                child: FormTextField(
                  hintText: context.localization.passwordTextField,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.medium,
                  vertical: Dimens.smallX,
                ),
                child: FormTextField(
                  hintText: context.localization.repeatPasswordTextField,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.medium,
                  vertical: Dimens.smallX,
                ),
                child: PrimaryButton(
                  buttonName: context.localization.signUpCTA,
                  onPressed: () {},
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
    );
  }
}
