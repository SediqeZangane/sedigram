import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/widget/post_widget.dart';
import 'package:sedigram/direct/presentation/direct_screen.dart';
import 'package:sedigram/timeline/application/timeline_bloc.dart';
import 'package:sedigram/timeline/application/timeline_event.dart';
import 'package:sedigram/timeline/application/timeline_state.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Sedigram',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(DirectScreen.routeNamed);
              },
              icon: const Icon(
                Icons.rocket_launch,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<TimelineBloc, TimelineState>(
            builder: (context, timelineState) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<TimelineBloc>().add(TimelineInitEvent());
                },
                child: timelineState.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: timelineState.listPost.length,
                        itemBuilder: (context, index) {
                          return PostWidget(
                            isMine: timelineState.listPost[index].isMine,
                            postDetailModel: timelineState.listPost[index],
                            liked: timelineState.listPost[index].liked,
                            like: () {
                              context.read<TimelineBloc>().add(
                                    TimelineLikeEvent(
                                      likedPost:
                                          timelineState.listPost[index].post,
                                    ),
                                  );
                            },
                            unlike: () {
                              context.read<TimelineBloc>().add(
                                    TimelineUnLikeEvent(
                                      unLikedPost:
                                          timelineState.listPost[index].post,
                                    ),
                                  );
                            },
                          );
                        },
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
