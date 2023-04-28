import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/theme/presentation/dimens.dart';

class TextSeparatorWidget extends StatelessWidget {
  final String text;

  const TextSeparatorWidget({
    super.key,
    this.text = "or",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.medium),
      child: Row(
        children: [
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width * 0.4,
            color: Colors.black.withOpacity(0.2),
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
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width * 0.4,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
