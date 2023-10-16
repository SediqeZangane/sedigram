abstract class ProfileEvent {}

class ProfileInitEvent implements ProfileEvent {
  final String userId;

  const ProfileInitEvent({
    required this.userId,
  });
}

class ProfileUpdateEvent implements ProfileEvent {
  final String userId;

  const ProfileUpdateEvent({
    required this.userId,
  });
}

class ProfileFollowEvent implements ProfileEvent {
  final String userId;

  const ProfileFollowEvent({
    required this.userId,
  });
}
