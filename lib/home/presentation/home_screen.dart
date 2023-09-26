import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';
import 'package:sedigram/create_post/application/create_post_bloc.dart';
import 'package:sedigram/create_post/application/create_post_event.dart';
import 'package:sedigram/create_post/presentation/create_post_screen.dart';
import 'package:sedigram/home/application/home_bloc.dart';
import 'package:sedigram/home/application/home_event.dart';
import 'package:sedigram/home/application/home_state.dart';
import 'package:sedigram/profile/presentation/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeNamed = 'homeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final body = _buildBody(state.currentIndex);
        return Scaffold(
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
                  Icons.search,
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

    return IndexedStack(
      alignment: Alignment.center,
      index: currentIndex,
      children: [
        const Text('home'),
        const Text('search'),
        BlocProvider(
          child: const CreatePostScreen(),
          create: (context) {
            return CreatePostBloc()..add(GetImagesEvent());
          },
        ),
        const Text('like'),
        const ProfileScreen(),
        const Text('Not Yet'),
      ],
    );
  }
}
