import 'package:flutter/material.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({super.key});

  static const routeName = '/new-post';

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  // https://stackoverflow.com/questions/72315755/close-an-expansiontile-when-another-expansiontile-is-tapped
  int selectedTile = -1;
  int sectionCount = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Today I learned..."),
        Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(20),
          child: const TextField(
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
