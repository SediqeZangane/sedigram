import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/theme/presentation/dimens.dart';

class TextSeparatorWidget extends StatelessWidget {
  final String text;

  const TextSeparatorWidget({
    super.key,
    this.text = 'OR',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.medium),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 2,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.small),
            child: Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 2,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
