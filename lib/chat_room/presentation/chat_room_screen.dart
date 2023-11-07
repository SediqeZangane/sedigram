import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/chat_room/application/chat_room_bloc.dart';
import 'package:sedigram/chat_room/application/chat_room_event.dart';
import 'package:sedigram/core/presentation/widget/form_text_field.dart';

class ChatRoomScreen extends StatefulWidget {
  static const String routeNamed = 'chatRoomScreen';

  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late final TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      body: Column(
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          ColoredBox(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: FormTextField(
                    hintText: 'Write your message',
                    border: InputBorder.none,
                    textEditingController: messageController,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<ChatRoomBloc>().add(
                          ChatRoomCreateEvent(
                            message: messageController.text,
                          ),
                        );
                  },
                  child: const Icon(
                    Icons.send,
                    color: Colors.red,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
