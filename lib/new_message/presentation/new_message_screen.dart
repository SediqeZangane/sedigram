import 'package:flutter/material.dart';

class NewMessageScreen extends StatelessWidget {
  static const String routeNamed = 'newMessageScreen';

  const NewMessageScreen({super.key});

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
          'New Message',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
