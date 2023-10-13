import 'package:sedigram/core/domain/user.dart';

class SearchState {
  final List<User> user;

  const SearchState({
    required this.user,
  });

  SearchState.init() : user = [];

  SearchState copyWith({
    List<User>? user,
  }) {
    return SearchState(
      user: user ?? this.user,
    );
  }
}
