// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as String,
      name: json['name'] as String,
      userName: json['userName'] as String,
      webSite: json['webSite'] as String,
      bio: json['bio'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      gender: json['gender'] as String,
      profilePicture: json['profilePicture'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'userName': instance.userName,
      'webSite': instance.webSite,
      'bio': instance.bio,
      'email': instance.email,
      'phone': instance.phone,
      'gender': instance.gender,
      'profilePicture': instance.profilePicture,
    };
