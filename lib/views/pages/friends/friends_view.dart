import 'package:flutter/material.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  static const routeName = '/friends';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Text('Friends'),
          SizedBox(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...[1, 2, 3, 4, 5].map((e) {
                  return const Text(
                    '1',
                    style: TextStyle(
                      backgroundColor: Colors.red,
                    ),
                  );
                }).toList()
              ],
            ),
          )
        ],
      ),
    );
  }
}
