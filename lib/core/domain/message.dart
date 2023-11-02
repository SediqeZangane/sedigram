import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String senderId;
  final String receiveId;
  final String content;
  final int createdAt;

  const Message({
    required this.senderId,
    required this.receiveId,
    required this.content,
    required this.createdAt,
  });

  Message.empty()
      : senderId = '',
        receiveId = '',
        content = '',
        createdAt = DateTime.now().millisecondsSinceEpoch;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  Message copyWith({
    String? senderId,
    String? receiveId,
    String? content,
    int? createdAt,
  }) {
    return Message(
      senderId: senderId ?? this.senderId,
      receiveId: receiveId ?? this.receiveId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
