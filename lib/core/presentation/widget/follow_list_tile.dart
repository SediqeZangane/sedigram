import 'package:flutter/material.dart';
import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/core/presentation/widget/profile_image.dart';
import 'package:sedigram/profile/presentation/profile_screen.dart';

class FollowListTile extends StatelessWidget {
  final List<User> user;

  final String? text;

  const FollowListTile({
    required this.user,
    this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: user.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            final selectedUserId = user[index].userId;

            Navigator.pushNamed(
              context,
              ProfileScreen.routeNamed,
              arguments: selectedUserId,
            );
          },
          leading: ProfileImage(
            user: user[index],
            radius: 24,
          ),
          title: Text(
            user[index].userName,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          subtitle: Text(user[index].name),
        );
      },
    );
  }
}
