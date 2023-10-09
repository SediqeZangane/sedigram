import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sedigram/core/domain/post.dart';

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
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 200,
            child: Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(imageUrl: posts[index].imageUrl),
                ),
                Text(
                  posts[index].caption,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
