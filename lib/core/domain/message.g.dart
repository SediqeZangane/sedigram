// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      senderId: json['senderId'] as String,
      receiveId: json['receiveId'] as String,
      content: json['content'] as String,
      createdAt: json['createdAt'] as int,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'senderId': instance.senderId,
      'receiveId': instance.receiveId,
      'content': instance.content,
      'createdAt': instance.createdAt,
    };
