import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/widget/follow_list_tile.dart';
import 'package:sedigram/follow/application/follow_bloc.dart';
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
                    // searchWidget(),
                    Expanded(
                      child: FollowListTile(
                        user: state.listUserFollowers,
                        text: 'Remove',
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    // searchWidget(),
                    Expanded(
                      child: FollowListTile(
                        user: state.listUserFollowings,
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

  Widget searchWidget() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: 45,
        child: TextField(
          // controller: controller,
          onChanged: (searchText) {},
          decoration: const InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.red,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
