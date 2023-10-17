import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sedigram/core/domain/post.dart';

class PostWidget extends StatelessWidget {
  static const List<String> actions = ['Delete', 'Edit'];

  final String userName;
  final bool isMine;
  final Post post;
  final void Function()? onDelete;

  const PostWidget({
    required this.userName,
    required this.isMine,
    required this.post,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 12,
            left: 4,
            right: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 24),
                  const SizedBox(width: 10),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              if (isMine)
                DropdownButton(
                  items: actions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (value == 'Delete') {
                      showDialog<void>(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text('Delete Post'),
                            content: const Text('Are you sure ?\n'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Yes'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  onDelete?.call();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('NO'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  icon: const Icon(Icons.more_horiz_sharp),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CachedNetworkImage(
            imageUrl: post.imageUrl,
          ),
        ),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.favorite_border),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Icon(Icons.mode_comment_outlined),
            ),
            Icon(Icons.share)
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            post.caption,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}
