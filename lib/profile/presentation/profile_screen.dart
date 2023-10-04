import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/edit_profile/presentation/edit_profile_screen.dart';
import 'package:sedigram/profile/application/profile_bloc.dart';
import 'package:sedigram/profile/application/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              )),
        ],
        actionsIconTheme: const IconThemeData(
          size: 30,
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        builder: (context, state) {
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
                      Text(state.userInfo.posts.length.toString()),
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Posts'),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(state.userInfo.followers.length.toString()),
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Followers'),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(state.userInfo.followings.length.toString()),
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
                    Text(state.currentUser.name),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(state.currentUser.userName),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      state.currentUser.bio,
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProfileScreen.routeNamed);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const EditProfileScreen()),
                    // );
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    return const ColoredBox(color: Colors.lightBlueAccent);
                  },
                  itemCount: 20,
                ),
              )),
            ],
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
