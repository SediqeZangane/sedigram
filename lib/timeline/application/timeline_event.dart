import 'package:sedigram/core/domain/post.dart';

abstract class TimelineEvent {}

class TimelineInitEvent implements TimelineEvent {}

class TimelineLikeEvent implements TimelineEvent {
  final Post likedPost;

  const TimelineLikeEvent({
    required this.likedPost,
  });
}

class TimelineUnLikeEvent implements TimelineEvent {
  final Post unLikedPost;

  const TimelineUnLikeEvent({
    required this.unLikedPost,
  });
}
