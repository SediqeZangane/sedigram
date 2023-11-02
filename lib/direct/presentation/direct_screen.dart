import 'package:flutter/material.dart';
import 'package:sedigram/new_message/presentation/new_message_screen.dart';

class DirectScreen extends StatelessWidget {
  static const String routeNamed = 'directScreen';

  const DirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
            icon: const Icon(Icons.create_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(NewMessageScreen.routeNamed);
            },
          ),
        ],
      ),
    );
  }
}
