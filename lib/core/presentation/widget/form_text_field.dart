import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';

class FormTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? textEditingController;
  final InputBorder? border;

  const FormTextField({
    required this.hintText,
    this.textEditingController,
    this.border,
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
          border: border ?? const OutlineInputBorder(),
        ),
        controller: textEditingController,
      ),
    );
  }
}
