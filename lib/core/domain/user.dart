import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String userId;
  final String name;
  final String userName;
  final String webSite;
  final String bio;
  final String email;
  final String phone;
  final String gender;

  User({
    required this.userId,
    required this.name,
    required this.userName,
    required this.webSite,
    required this.bio,
    required this.email,
    required this.phone,
    required this.gender,
  });

  User.empty()
      : userId = '',
        name = '',
        userName = '',
        webSite = '',
        bio = '',
        email = '',
        phone = '',
        gender = '';

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     userId: json['userId'] as String? ?? '',
  //     name: json['name'] as String? ?? '',
  //     userName: json['userName'] as String? ?? '',
  //     webSite: json['webSite'] as String? ?? '',
  //     bio: json['bio'] as String? ?? '',
  //     email: json['email'] as String? ?? '',
  //     phone: json['phone'] as String? ?? '',
  //     gender: json['gender'] as String? ?? '',
  //   );
  // }

  User copyWith({
    String? userId,
    String? name,
    String? userName,
    String? webSite,
    String? bio,
    String? email,
    String? phone,
    String? gender,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      webSite: webSite ?? this.webSite,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
    );
  }
}
