import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/domain/user.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/core/presentation/widget/form_text_field.dart';
import 'package:sedigram/edit_profile/application/edit_profile_bloc.dart';
import 'package:sedigram/edit_profile/application/edit_profile_event.dart';
import 'package:sedigram/edit_profile/application/edit_profile_state.dart';
import 'package:shimmer/shimmer.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeNamed = 'editProfileScreen';

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  User newUser = User.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 16, left: 4),
          child: TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 12),
            child: TextButton(
              child: Text(
                'Done',
                style:
                    TextStyle(color: context.colorScheme.primary, fontSize: 16),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<EditProfileBloc>().add(
                        EditProfileSaveEvent(updateUser: newUser),
                      );
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('info Saved')),
                  // );
                }
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: BlocConsumer<EditProfileBloc, EditProfileState>(
          builder: listInfo,
          listener: (buildContext, state) {
            if (state.saved) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('info Saved')),
              );
              Navigator.of(context).pop();
            }

            if (state.error != '') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
        ),
      ),
    );
  }

  Widget profileInfo({
    required String nameField,
    required String fieldInfo,
    FormFieldValidator<String?>? validator,
    FormFieldSetter<String>? onSaved,
  }) {
    return infoRow(
      child: Row(
        children: [
          Expanded(child: Text(nameField)),
          Expanded(
            flex: 3,
            child: BlocBuilder<EditProfileBloc, EditProfileState>(
              builder: (BuildContext context, EditProfileState state) {
                if (state.isLoading) {
                  return Center(child: shimmerWidget());
                } else {
                  return FormTextField(
                    hintText: nameField,
                    border: const UnderlineInputBorder(),
                    validator: validator,
                    onSaved: onSaved,
                    initialValue: fieldInfo,
                  );
                }
              },
            ),
          ),
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
    // if (state.isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // } else
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 48,
            ),
            infoRow(
              child: Text(
                'Change Profile Photo',
                style:
                    TextStyle(color: context.colorScheme.primary, fontSize: 16),
              ),
            ),
            const Divider(),
            profileInfo(
              nameField: 'Name',
              fieldInfo: state.user.name,
              onSaved: (value) {
                newUser = newUser.copyWith(name: value);
              },
            ),
            profileInfo(
              nameField: 'Username',
              fieldInfo: state.user.userName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'pls fill the field';
                }
                return null;
              },
              onSaved: (value) {
                newUser = newUser.copyWith(userName: value);
              },
            ),
            profileInfo(
              nameField: 'Website',
              fieldInfo: state.user.webSite,
              onSaved: (value) {
                newUser = newUser.copyWith(webSite: value);
              },
            ),
            profileInfo(
              nameField: 'Bio',
              fieldInfo: state.user.bio,
              onSaved: (value) {
                newUser = newUser.copyWith(bio: value);
              },
            ),
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
            profileInfo(
              nameField: 'Email',
              fieldInfo: state.user.email,
              onSaved: (value) {
                newUser = newUser.copyWith(email: value);
              },
            ),
            profileInfo(
              nameField: 'Phone',
              fieldInfo: state.user.phone,
              onSaved: (value) {
                newUser = newUser.copyWith(phone: value);
              },
            ),
            profileInfo(
              nameField: 'Gender',
              fieldInfo: state.user.gender,
              onSaved: (value) {
                newUser = newUser.copyWith(gender: value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        height: 10,
        width: 100,
        color: Colors.green,
      ),
    );
  }
}
