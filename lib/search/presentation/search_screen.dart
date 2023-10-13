import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 45,
          child: TextField(
            controller: controller,
            onChanged: (searchText) {
              context
                  .read<SearchBloc>()
                  .add(SearchUpdateEvent(text: searchText));
            },
            decoration: const InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.cyanAccent,
                ),
                title: Text(state.user[index].userName),
                subtitle: Text(state.user[index].name),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
