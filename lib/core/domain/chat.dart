import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  final String id;
  final List<String> userIds;

  const Chat({
    required this.id,
    required this.userIds,
  });

  Chat.empty()
      : id = '',
        userIds = [];

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);

  Chat copyWith({
    String? id,
    List<String>? userIds,
  }) {
    return Chat(
      id: id ?? this.id,
      userIds: userIds ?? this.userIds,
    );
  }
}
