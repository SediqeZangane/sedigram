import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/widget/follow_list_tile.dart';
import 'package:sedigram/core/presentation/widget/search_box.dart';
import 'package:sedigram/search/application/search_bloc.dart';
import 'package:sedigram/search/application/search_event.dart';
import 'package:sedigram/search/application/search_state.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();

  const SearchScreen({
    super.key,
  });
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SearchBox(
          onChanged: (searchText) {
            context.read<SearchBloc>().add(SearchUpdateEvent(text: searchText));
          },
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return FollowListTile(
            user: state.user,
          );
        },
      ),
    );
  }
}
