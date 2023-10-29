import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final void Function(String)? onChanged;

  const SearchBox({required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        onChanged: (searchText) {
          onChanged?.call(searchText);
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
    );
  }
}
