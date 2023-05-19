import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/save_post/application/save_post_event.dart';
import 'package:sedigram/save_post/application/save_post_state.dart';

class SavePostBloc extends Bloc<SavePostEvent, SavePostState> {
  SavePostBloc() : super(SavePostState.init()) {
    on<SavePostEvent>(
      (event, emit) {},
    );
  }
}
