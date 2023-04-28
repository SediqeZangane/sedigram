import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/core/presentation/widget/form_text_field.dart';
import 'package:sedigram/core/presentation/widget/have_account_button.dart';
import 'package:sedigram/core/presentation/widget/primary_button.dart';
import 'package:sedigram/core/presentation/widget/text_separator_widget.dart';
import 'package:sedigram/sign_up/presentation/sign_up_screen.dart';
import 'package:sedigram/theme/presentation/dimens.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  horizontal: Dimens.medium,
                  vertical: Dimens.smallX,
                ),
                child: FormTextField(hintText: 'email'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.medium,
                  vertical: Dimens.smallX,
                ),
                child: FormTextField(hintText: 'Password'),
              ),
              forgetPassWidget(context),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.medium),
                child: PrimaryButton(buttonName: 'Log in'),
              ),
              const SizedBox(height: Dimens.xxLarge),
              const TextSeparatorWidget(),
              const SizedBox(height: Dimens.xxLarge),
              HaveAccountButton(
                description: "Don't have an account? ",
                link: 'Sign up.',
                onClick: () {
                  Navigator.push(
                    context,
                    // ignore: inference_failure_on_instance_creation
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
              ),
            ],
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
            'Forget Password?',
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
