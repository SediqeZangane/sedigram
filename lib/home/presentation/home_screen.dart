import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/create_post/application/create_post_bloc.dart';
import 'package:sedigram/create_post/application/create_post_event.dart';
import 'package:sedigram/create_post/presentation/create_post_screen.dart';
import 'package:sedigram/home/application/home_bloc.dart';
import 'package:sedigram/home/application/home_event.dart';
import 'package:sedigram/home/application/home_state.dart';
import 'package:sedigram/profile/application/profile_bloc.dart';
import 'package:sedigram/profile/application/profile_event.dart';
import 'package:sedigram/profile/presentation/profile_screen.dart';
import 'package:sedigram/search/application/search_bloc.dart';
import 'package:sedigram/search/presentation/search_screen.dart';
import 'package:sedigram/timeline/application/timeline_bloc.dart';
import 'package:sedigram/timeline/application/timeline_event.dart';
import 'package:sedigram/timeline/presentation/timeline_screen.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';
import 'package:sedigram/user/application/global_user_state.dart';

class HomeScreen extends StatelessWidget {
  static const String routeNamed = 'homeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final body = _buildBody(state.currentIndex);
        return SafeArea(
          child: Scaffold(
            body: Center(child: body),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: context.colorScheme.onSurface,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search_sharp,
                    color: context.colorScheme.onSurface,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: context.colorScheme.onSurface,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.heart_broken,
                    color: context.colorScheme.onSurface,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle,
                    color: context.colorScheme.onSurface,
                  ),
                  label: '',
                ),
              ],
              onTap: (value) {
                context
                    .read<HomeBloc>()
                    .add(ChangedBottomNavigation(index: value));
              },
              currentIndex: state.currentIndex,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(int currentIndex) {
    // switch (currentIndex) {
    //   case 0:
    //     return const Text('home');
    //   case 1:
    //     return const Text('search');
    //   case 2:
    //     return BlocProvider(
    //       child: const CreatePostScreen(),
    //       create: (context) {
    //         return CreatePostBloc()..add(GetImagesEvent());
    //       },
    //     );
    //   case 3:
    //     return const Text('like');
    //   case 4:
    //     return const Text('profile');
    //   default:
    //     return const Text('Not Yet');
    // }
    return BlocBuilder<GlobalUserBloc, GlobalUserState>(
      builder: (context, state) {
        if (state.user.userId.isEmpty) {
          return const CircularProgressIndicator();
        }

        return IndexedStack(
          alignment: Alignment.center,
          index: currentIndex,
          children: [
            BlocProvider(
              child: const TimelineScreen(),
              create: (context) {
                return TimelineBloc(
                  firebaseAuth: FirebaseAuth.instance,
                  firestoreService:
                      FirestoreService(FirebaseFirestore.instance),
                  globalUserBloc: GlobalUserBloc(),
                )..add(TimelineInitEvent());
              },
            ),
            BlocProvider(
              create: (context) {
                return SearchBloc(
                  firebaseAuth: FirebaseAuth.instance,
                  firestoreService:
                      FirestoreService(FirebaseFirestore.instance),
                );
              },
              child: const SearchScreen(),
            ),
            BlocProvider(
              child: const CreatePostScreen(nextPage: NextPage.savePost),
              create: (context) {
                return CreatePostBloc()..add(GetImagesEvent());
              },
            ),
            const Text('like'),
            BlocProvider(
              create: (context) {
                debugPrint('id global : ${state.user.userId}');
                return ProfileBloc(
                  FirebaseAuth.instance,
                  FirestoreService(FirebaseFirestore.instance),
                  GlobalUserBloc(),
                )..add(
                    ProfileInitEvent(
                      userId: state.user.userId,
                    ),
                  );
              },
              child: ProfileScreen(
                userId: state.user.userId,
              ),
            ),
          ],
        );
      },
    );
  }
}
