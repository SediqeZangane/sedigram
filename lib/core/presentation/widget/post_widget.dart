import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/model/post_details_model.dart';

class PostWidget extends StatelessWidget {
  static const List<String> actions = ['Delete'];

  final PostDetailModel postDetailModel;
  final bool isMine;
  final void Function()? onDelete;
  final bool liked;
  final void Function()? like;
  final void Function()? unlike;

  const PostWidget({
    required this.postDetailModel,
    required this.isMine,
    required this.liked,
    required this.like,
    required this.unlike,
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
              SizedBox(
                height: 54,
                child: Row(
                  children: [
                    const CircleAvatar(radius: 32),
                    const SizedBox(width: 10),
                    Text(
                      postDetailModel.user.userName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (isMine)
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    items:
                        actions.map<DropdownMenuItem<String>>((String value) {
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
                    icon: const Icon(
                      Icons.more_horiz_sharp,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CachedNetworkImage(
            imageUrl: postDetailModel.post.imageUrl,
            fit: BoxFit.fitWidth,
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                onPressed: () {
                  if (liked) {
                    unlike?.call();
                  } else {
                    like?.call();
                  }
                },
                icon: Icon(
                  Icons.favorite,
                  size: 26,
                  color: liked ? Colors.red : Colors.green,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Icon(
                Icons.mode_comment_outlined,
                size: 23,
              ),
            ),
            const Icon(
              Icons.share,
              size: 23,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            postDetailModel.post.caption,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
