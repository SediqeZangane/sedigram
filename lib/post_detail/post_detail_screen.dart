import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/domain/post.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';
import 'package:sedigram/user/application/global_user_state.dart';

class PostDetailScreen extends StatelessWidget {
  static const String routeNamed = 'postDetailScreen';

  final List<Post> posts;

  const PostDetailScreen({
    required this.posts,
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
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 4),
                child: Row(
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
                    )
                  ],
                ),
              ),
              CachedNetworkImage(
                imageUrl: posts[index].imageUrl,
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
                  posts[index].caption,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
