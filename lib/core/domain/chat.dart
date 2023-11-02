import 'package:json_annotation/json_annotation.dart';
import 'package:sedigram/core/domain/user.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  final String id;
  final List<User> users;

  const Chat({
    required this.id,
    required this.users,
  });

  Chat.empty()
      : id = '',
        users = [];

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);

  Chat copyWith({
    String? id,
    List<User>? users,
  }) {
    return Chat(
      id: id ?? this.id,
      users: users ?? this.users,
    );
  }
}
