import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/edit_profile/application/edit_profile_bloc.dart';
import 'package:sedigram/edit_profile/application/edit_profile_state.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeNamed = 'editProfileScreen';

  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 16, left: 4),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
        title: const Center(
          child: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 12),
            child: Text(
              'Done',
              style:
                  TextStyle(color: context.colorScheme.primary, fontSize: 16),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child:
            BlocBuilder<EditProfileBloc, EditProfileState>(builder: listInfo),
      ),
    );
  }

  Widget profileInfo(String field, String info) {
    return infoRow(
      child: Row(
        children: [
          Expanded(child: Text(field)),
          Expanded(flex: 3, child: Text(info))
        ],
      ),
    );
  }

  Widget infoRow({required Widget child}) {
    return SizedBox(
      height: 48,
      child: Center(child: child),
    );
  }

  Widget listInfo(BuildContext context, EditProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CircleAvatar(
          radius: 48,
        ),
        infoRow(
          child: Text(
            'Change Profile Photo',
            style: TextStyle(color: context.colorScheme.primary, fontSize: 16),
          ),
        ),
        profileInfo('Name', state.user.name),
        profileInfo('Username', state.user.userName),
        profileInfo('Website', state.user.webSite),
        profileInfo('Bio', state.user.bio),
        infoRow(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Switch to Professional Account ',
              style: TextStyle(color: context.colorScheme.primary),
            ),
          ),
        ),
        infoRow(
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Private Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        profileInfo('Email', state.user.email),
        profileInfo('Phone', state.user.phone),
        profileInfo('Gender', state.user.gender),
      ],
    );
  }
}
