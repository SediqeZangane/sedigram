import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/post_detail/application/post_detail_bloc.dart';
import 'package:sedigram/post_detail/application/post_detail_event.dart';
import 'package:sedigram/post_detail/application/post_detail_state.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';
import 'package:sedigram/user/application/global_user_state.dart';

class PostDetailScreen extends StatelessWidget {
  static const String routeNamed = 'postDetailScreen';

  final List<String> actions = ['Delete', 'Edit'];

  PostDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 36),
            child: Text(
              'Posts',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: BlocBuilder<PostDetailBloc, PostDetailState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
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
                            BlocBuilder<GlobalUserBloc, GlobalUserState>(
                              builder: (context, state) {
                                return Text(
                                  state.user.userName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
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
                                                      state.posts[index],
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
                  CachedNetworkImage(
                    imageUrl: state.posts[index].imageUrl,
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
                      state.posts[index].caption,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
