import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';

class HaveAccountButton extends StatelessWidget {
  final String description;
  final String link;
  final VoidCallback onClick;

  const HaveAccountButton({
    super.key,
    required this.description,
    required this.link,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          description,
          style: context.textTheme.titleSmall
              ?.copyWith(color: Colors.black.withOpacity(0.4)),
        ),
        GestureDetector(
          onTap: onClick,
          child: Text(
            link,
            style: context.textTheme.titleSmall
                ?.copyWith(color: context.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
