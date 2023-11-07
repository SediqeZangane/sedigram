import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String receiveId;
  final String content;
  final int createdAt;

  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.receiveId,
    required this.content,
    required this.createdAt,
  });

  Message.empty()
      : id = '',
        chatId = '',
        senderId = '',
        receiveId = '',
        content = '',
        createdAt = DateTime.now().millisecondsSinceEpoch;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  Message copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? receiveId,
    String? content,
    int? createdAt,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      receiveId: receiveId ?? this.receiveId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
