import 'package:flutter/material.dart';

abstract class NewMessageEvent {}

class NewMessageInitEvent implements NewMessageEvent {}

class NewMessageSearchEvent implements NewMessageEvent {
  final String searchText;

  const NewMessageSearchEvent({
    required this.searchText,
  });
}

class NewMessageSelectUserEvent implements NewMessageEvent {
  final String selectedUser;
  final NavigatorState navigatorState;

  const NewMessageSelectUserEvent({
    required this.selectedUser,
    required this.navigatorState,
  });
}
