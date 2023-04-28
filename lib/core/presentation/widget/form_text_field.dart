import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/theme/presentation/dimens.dart';

class FormTextField extends StatelessWidget {
  final String hintText;

  const FormTextField({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorScheme.onSurfaceVariant,
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: context.textTheme.titleSmall
              ?.copyWith(color: Colors.black.withOpacity(0.2)),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.smallXX),
            ),
          ),
        ),
      ),
    );
  }
}
