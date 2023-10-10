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
        const Text(
          'Today I learned...',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.symmetric(
            horizontal: 48,
            vertical: 16,
          ),
          child: const TextField(
            minLines: 5,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              hintText: '''
...to fly.
...how to ride a bike.''',
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 36,
            ),
            ElevatedButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
