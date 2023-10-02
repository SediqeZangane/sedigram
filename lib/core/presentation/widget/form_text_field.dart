import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';

class FormTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? textEditingController;
  final InputBorder? border;
  final FormFieldValidator<String?>? validator;
  final FormFieldSetter<String>? onSaved;

  const FormTextField({
    required this.hintText,
    this.textEditingController,
    this.border,
    this.validator,
    this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorScheme.onSurfaceVariant,
      child: TextFormField(
        validator: validator,
        onSaved: onSaved,
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
