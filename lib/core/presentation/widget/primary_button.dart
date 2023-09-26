import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/theme/presentation/dimens.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? bgColor;
  final String? leadingImage;
  final bool borderSide;

  const PrimaryButton({
    required this.buttonName,
    required this.onPressed,
    this.textColor,
    this.bgColor,
    this.leadingImage,
    this.borderSide = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.primaryButtonHeight,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(bgColor ?? context.colorScheme.primary),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(
                color: borderSide
                    ? context.colorScheme.onSurface
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingImage != null)
              SizedBox(
                height: 25,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Image.asset(leadingImage!),
                ),
              ),
            Text(
              buttonName,
              style: context.textTheme.titleMedium
                  ?.copyWith(color: textColor ?? Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
