import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/widget/form_text_field.dart';
import 'package:sedigram/core/presentation/widget/have_account_button.dart';
import 'package:sedigram/core/presentation/widget/primary_button.dart';
import 'package:sedigram/core/presentation/widget/text_separator_widget.dart';
import 'package:sedigram/login/presentation/login_screen.dart';
import 'package:sedigram/theme/presentation/dimens.dart';

class SignUpScreen extends StatelessWidget {
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Padding(
              padding: EdgeInsets.only(top: Dimens.large),
              child: Text(
                'Sedigram',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: Dimens.xxLarge,
            ),
            const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.medium, vertical: Dimens.smallX),
                child: FormTextField(hintText: 'email')),
            const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.medium, vertical: Dimens.smallX),
                child: FormTextField(hintText: 'Password')),
            const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.medium, vertical: Dimens.smallX),
                child: FormTextField(hintText: 'Repeat Password')),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.medium, vertical: Dimens.smallX),
              child: PrimaryButton(buttonName: 'Sign up'),
            ),
            const SizedBox(
              height: Dimens.xxLarge,
            ),
            const TextSeparatorWidget(),
            const SizedBox(
              height: Dimens.xxLarge,
            ),
            HaveAccountButton(
              description: "Already have an account? ",
              link: "Log in.",
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
