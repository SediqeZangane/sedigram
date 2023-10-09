// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      postId: json['postId'] as String,
      caption: json['caption'] as String,
      imageUrl: json['imageUrl'] as String,
      createdAt: json['createdAt'] as int,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postId': instance.postId,
      'caption': instance.caption,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
      'userId': instance.userId,
    };
