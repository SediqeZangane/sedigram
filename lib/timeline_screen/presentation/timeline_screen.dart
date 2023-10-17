import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/core/presentation/widget/post_widget.dart';
import 'package:sedigram/timeline_screen/application/timeline_bloc.dart';
import 'package:sedigram/timeline_screen/application/timeline_event.dart';
import 'package:sedigram/timeline_screen/application/timeline_state.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<TimelineBloc, TimelineState>(
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
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
