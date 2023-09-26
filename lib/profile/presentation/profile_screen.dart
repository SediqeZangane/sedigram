import 'package:flutter/material.dart';
import 'package:sedigram/core/presentation/util/context_extension.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Center(child: Text('')),
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: 'state.folddddder',
              items: const [],
              onChanged: (value) {},
            ),
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              )),
        ],
        actionsIconTheme: const IconThemeData(
          size: 30,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CircleAvatar(
                radius: 48,
              ),
              Column(
                children: const [Text('21'), Text('Posts')],
              ),
              Column(
                children: const [Text('212'), Text('Followers')],
              ),
              Column(
                children: const [Text('195'), Text('Following')],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28, bottom: 20, left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Jacob West'),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Posts',
                  style: TextStyle(fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: context.colorScheme.onSurface),
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                return const ColoredBox(color: Colors.lightBlueAccent);
              },
              itemCount: 20,
            ),
          )),
        ],
      ),
    );
  }
}
