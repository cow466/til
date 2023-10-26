import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:til/data/post_db.dart';
import 'package:til/data/user_db.dart';
import 'package:til/settings/sign_in.dart';
import 'package:til/views/pages/home/home_view.dart';

class NewPostView extends ConsumerStatefulWidget {
  const NewPostView({super.key});

  static const routeName = '/new-post';

  @override
  ConsumerState<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends ConsumerState<NewPostView> {
  late TextEditingController _controller;
  late PostDB postDB;
  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    postDB = ref.read(postDBProvider);
    loggedInUser = ref.read(loggedInUserNotifierProvider)!;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // https://stackoverflow.com/questions/72315755/close-an-expansiontile-when-another-expansiontile-is-tapped
  int selectedTile = -1;
  int sectionCount = 3;

  void handleCreateNewPost(content) {
    postDB.addPost(
      userId: loggedInUser.id,
      content: content,
    );
    context.go(HomeView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    postDB = ref.watch(postDBProvider);

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
          child: TextField(
            controller: _controller,
            onSubmitted: (String value) async {
              handleCreateNewPost(value);
            },
            minLines: 5,
            maxLines: 5,
            decoration: const InputDecoration(
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
              onPressed: () {
                _controller.text = '';
              },
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
              onPressed: () {
                handleCreateNewPost(_controller.text);
              },
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
