import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/home/application/home_event.dart';
import 'package:sedigram/home/application/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.init()) {
    on<HomeEvent>(
      (event, emit) {
        if (event is ChangedBottomNavigation) {
          emit(state.copyWith(currentIndex: event.index));
        }
      },
    );
  }
}
