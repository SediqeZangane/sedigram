import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  String userId;
  List<String> followers;
  List<String> followings;
  List<String> posts;

  UserInfo({
    required this.userId,
    required this.followers,
    required this.followings,
    required this.posts,
  });

  UserInfo.empty()
      : userId = '',
        followers = [],
        followings = [],
        posts = [];

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  UserInfo copyWith({
    String? userId,
    List<String>? followers,
    List<String>? followings,
    List<String>? posts,
  }) {
    return UserInfo(
      userId: userId ?? this.userId,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      posts: posts ?? this.posts,
    );
  }
}
