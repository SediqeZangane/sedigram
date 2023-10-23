import 'package:flutter/material.dart';

class ProfilePhotoScreen extends StatelessWidget {
  static const String routeNamed = 'profilePhotoScreen';

  const ProfilePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.builder(
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          return Container(height: 5, width: 5, color: Colors.pink);
        },
      ),
    );
  }
}
