// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      userId: json['userId'] as String,
      followers:
          (json['followers'] as List<dynamic>).map((e) => e as String).toList(),
      followings: (json['followings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      posts: (json['posts'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'userId': instance.userId,
      'followers': instance.followers,
      'followings': instance.followings,
      'posts': instance.posts,
    };
