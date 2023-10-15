import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/auth/application/auth_bloc.dart';
import 'package:sedigram/auth/application/auth_event.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/edit_profile/presentation/edit_profile_screen.dart';
import 'package:sedigram/login/presentation/login_screen.dart';
import 'package:sedigram/post_detail/presentation/post_detail_screen.dart';
import 'package:sedigram/post_detail/presentation/post_detail_screen_arguments.dart';
import 'package:sedigram/profile/application/profile_bloc.dart';
import 'package:sedigram/profile/application/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeNamed = 'profileScreen';

  final String userId;

  const ProfileScreen({
    required this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: const Center(child: Text('')),
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: 'state.folddddder',
              items: const [],
              onChanged: (value) {},
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
      ),
      endDrawer: Drawer(
        child: ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Log Out'),
          onTap: () {
            Navigator.of(context).pop();
            deleteDialog(context);
          },
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, profileState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircleAvatar(
                    radius: 48,
                  ),
                  Column(
                    children: [
                      Text(profileState.userInfo.posts.length.toString()),
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Posts'),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(profileState.userInfo.followers.length.toString()),
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Followers'),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(profileState.userInfo.followings.length.toString()),
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Following'),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8, left: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profileState.user.name),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(profileState.user.userName),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      profileState.user.bio,
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              if (profileState.isMine)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EditProfileScreen.routeNamed);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(
                            color: Colors.black12,
                          ),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(color: context.colorScheme.onSurface),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PostDetailScreen.routeNamed,
                            arguments: PostDetailScreenArguments(
                              posts: profileState.posts,
                              postIndex: index,
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: profileState.posts[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    itemCount: profileState.posts.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure ?\n'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                context.read<AuthBloc>().add(LogOutEvent());
                Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeNamed,
                  (route) => false,
                );
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
