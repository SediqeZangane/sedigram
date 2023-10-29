import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';
import 'package:sedigram/user/application/global_user_state.dart';

class ProfileImage extends StatelessWidget {
  final User user;
  final double radius;

  const ProfileImage({required this.user, this.radius = 32, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalUserBloc, GlobalUserState>(
      builder: (context, state) {
        User userToBuild = user;
        if (user.userId == state.user.userId) {
          userToBuild = state.user;
        }
        if (userToBuild.profilePicture != '') {
          return CachedNetworkImage(
            imageUrl: userToBuild.profilePicture,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: radius,
              backgroundImage: imageProvider,
            ),
            placeholder: (context, url) {
              return CircleAvatar(
                radius: radius,
              );
            },
          );
        } else {
          return CircleAvatar(
            radius: radius,
          );
        }
      },
    );
  }
}
