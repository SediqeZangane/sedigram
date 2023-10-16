import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sedigram/post_detail/application/post_detail_bloc.dart';
import 'package:sedigram/post_detail/application/post_detail_event.dart';
import 'package:sedigram/post_detail/application/post_detail_state.dart';

class PostDetailScreen extends StatelessWidget {
  static const String routeNamed = 'postDetailScreen';
  static const List<String> actions = ['Delete', 'Edit'];

  final int postIndex;
  final String userName;

  const PostDetailScreen({
    required this.postIndex,
    required this.userName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Posts',
          style: TextStyle(color: Colors.black),
        ),
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      body: BlocBuilder<PostDetailBloc, PostDetailState>(
        builder: (context, postState) {
          return ScrollablePositionedList.builder(
            initialScrollIndex: postIndex,
            itemCount: postState.posts.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        if (postState.isMine)
                          DropdownButton(
                            items: actions
                                .map<DropdownMenuItem<String>>((String value) {
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
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Yes'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            context.read<PostDetailBloc>().add(
                                                  PostDetailDeleteEvent(
                                                    selectedPost:
                                                        postState.posts[index],
                                                  ),
                                                );
                                          },
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
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
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: postState.posts[index].imageUrl,
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.favorite_border),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.mode_comment_outlined),
                      ),
                      Icon(Icons.share)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 12),
                    child: Text(
                      postState.posts[index].caption,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Divider()
                ],
              );
            },
          );
        },
      ),
    );
  }
}
