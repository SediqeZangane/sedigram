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
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    CircleAvatar(radius: 24),
                    SizedBox(width: 10),
                    Text('userName'),
                  ],
                ),
                CachedNetworkImage(
                  imageUrl: posts[index].imageUrl,
                  fit: BoxFit.fitWidth,
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
