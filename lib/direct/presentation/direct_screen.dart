import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/chat_room/presentation/chat_room_screen.dart';
import 'package:sedigram/core/presentation/widget/follow_list_tile.dart';
import 'package:sedigram/direct/application/direct_bloc.dart';
import 'package:sedigram/direct/application/direct_state.dart';
import 'package:sedigram/new_message/presentation/new_message_screen.dart';

class DirectScreen extends StatelessWidget {
  static const String routeNamed = 'directScreen';

  const DirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Sedigram',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.create_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(NewMessageScreen.routeNamed);
            },
          ),
        ],
      ),
      body: BlocBuilder<DirectBloc, DirectState>(
        builder: (context, state) {
          if (state.listUsers == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.listUsers!.isEmpty) {
            return const Center(
              child: Text('Make A New Conversation'),
            );
          }

          return FollowListTile(
            user: state.listUsers!,
            text: 'Following',
            function: (selectedUserId) {
              final chat = state.listChats
                  .where((element) => element.userIds.contains(selectedUserId))
                  .firstOrNull;

              Navigator.pushNamed(
                context,
                ChatRoomScreen.routeNamed,
                arguments: chat,
              );
            },
          );
        },
      ),
    );
  }
}
