import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sedigram/core/presentation/widget/post_widget.dart';
import 'package:sedigram/post_detail/application/post_detail_bloc.dart';
import 'package:sedigram/post_detail/application/post_detail_event.dart';
import 'package:sedigram/post_detail/application/post_detail_state.dart';

class PostDetailScreen extends StatelessWidget {
  static const String routeNamed = 'postDetailScreen';

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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<PostDetailBloc, PostDetailState>(
        builder: (context, postState) {
          return ScrollablePositionedList.builder(
            initialScrollIndex: postIndex,
            itemCount: postState.posts.length,
            itemBuilder: (context, index) {
              return PostWidget(
                isMine: postState.isMine,
                postDetailModel: postState.posts[index],
                onDelete: () {
                  context.read<PostDetailBloc>().add(
                        PostDetailDeleteEvent(
                          selectedPost: postState.posts[index].post,
                        ),
                      );
                },
              );
            },
          );
        },
      ),
    );
  }
}
