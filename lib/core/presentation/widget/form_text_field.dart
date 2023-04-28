import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';

class FormTextField extends StatelessWidget {
  final String hintText;

  const FormTextField({
    required this.hintText,
    super.key,
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
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
