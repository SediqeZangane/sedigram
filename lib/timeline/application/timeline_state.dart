import 'package:sedigram/core/presentation/model/post_details_model.dart';

class TimelineState {
  final List<PostDetailModel> listPost;
  final bool isLoading;

  const TimelineState({
    required this.listPost,
    required this.isLoading,
  });

  TimelineState.init()
      : listPost = [],
        isLoading = false;

  TimelineState copyWith({
    List<PostDetailModel>? listPost,
    bool? isLoading,
  }) {
    return TimelineState(
      listPost: listPost ?? this.listPost,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
