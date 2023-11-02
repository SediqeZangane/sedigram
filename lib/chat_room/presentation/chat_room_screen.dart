import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/widget/form_text_field.dart';

class ChatRoomScreen extends StatelessWidget {
  static const String routeNamed = 'chatRoomScreen';

  const ChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      body: const Column(
        children: [
          Expanded(
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
                )),
                Icon(
                  Icons.send,
                  color: Colors.red,
                  size: 28,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
