import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/widget/follow_list_tile.dart';
import 'package:sedigram/core/presentation/widget/search_box.dart';
import 'package:sedigram/follow/application/follow_bloc.dart';
import 'package:sedigram/follow/application/follow_event.dart';
import 'package:sedigram/follow/application/follow_state.dart';

class FollowScreen extends StatefulWidget {
  static const String routeNamed = 'followScreen';

  const FollowScreen({super.key});

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<FollowBloc, FollowState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    icon: Text(
                      ' ${state.listUserFollowers.length}            Followers',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      ' ${state.listUserFollowings.length}          Followings',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    SearchBox(
                      onChanged: (searchText) {
                        context.read<FollowBloc>().add(
                              FollowersUpdateSearchEvent(
                                followersSearch: searchText,
                              ),
                            );
                      },
                    ),
                    Expanded(
                      child: FollowListTile(
                        user: state.listSearchFollowers,
                        text: 'Remove',
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SearchBox(
                      onChanged: (searchText) {
                        context.read<FollowBloc>().add(
                              FollowingsUpdateSearchEvent(
                                followingsSearch: searchText,
                              ),
                            );
                      },
                    ),
                    Expanded(
                      child: FollowListTile(
                        user: state.listSearchFollowings,
                        text: 'Following',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
