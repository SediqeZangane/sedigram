import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/widget/follow_list_tile.dart';
import 'package:sedigram/core/presentation/widget/search_box.dart';
import 'package:sedigram/new_message/application/new_message_bloc.dart';
import 'package:sedigram/new_message/application/new_message_event.dart';
import 'package:sedigram/new_message/application/new_message_state.dart';

class NewMessageScreen extends StatelessWidget {
  static const String routeNamed = 'newMessageScreen';

  const NewMessageScreen({super.key});

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
          'New Message',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(),
            SearchBox(
              onChanged: (searchText) {
                context
                    .read<NewMessageBloc>()
                    .add(NewMessageSearchEvent(searchText: searchText));
              },
            ),
            Expanded(
              child: BlocBuilder<NewMessageBloc, NewMessageState>(
                builder: (context, state) {
                  if (state.listSearchFollowings.isNotEmpty) {
                    return FollowListTile(
                      user: state.listSearchFollowings,
                      function: (selectedUserId) {
                        context.read<NewMessageBloc>().add(
                              NewMessageSelectUserEvent(
                                selectedUser: selectedUserId,
                                navigatorState: Navigator.of(context),
                              ),
                            );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
