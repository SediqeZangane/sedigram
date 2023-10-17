import 'package:sedigram/core/domain/post.dart';

class TimelineState {
  final String userName;
  final List<Post> listPost;
  final bool isLoading;

  const TimelineState({
    required this.userName,
    required this.listPost,
    required this.isLoading,
  });

  TimelineState.init()
      : userName = '',
        listPost = [],
        isLoading = false;

  TimelineState copyWith({
    String? userName,
    List<Post>? listPost,
    bool? isLoading,
  }) {
    return TimelineState(
      userName: userName ?? this.userName,
      listPost: listPost ?? this.listPost,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
