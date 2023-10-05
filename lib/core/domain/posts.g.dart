// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Posts _$PostsFromJson(Map<String, dynamic> json) => Posts(
      postId: json['postId'] as String,
      caption: json['caption'] as String,
      imageUrl: json['imageUrl'] as String,
      createdAt: json['createdAt'] as int,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$PostsToJson(Posts instance) => <String, dynamic>{
      'postId': instance.postId,
      'caption': instance.caption,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
      'userId': instance.userId,
    };
