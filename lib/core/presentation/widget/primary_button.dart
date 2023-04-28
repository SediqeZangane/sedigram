import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/theme/presentation/dimens.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonName;

  const PrimaryButton({
    required this.buttonName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.primaryButtonHeight,
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(context.colorScheme.primary),
        ),
        child: Text(
          buttonName,
          style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
