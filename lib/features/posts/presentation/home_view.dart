import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:til/features/loading/presentation/loading_view.dart';
import 'package:til/features/posts/domain/post.dart';

import '../data/post_db.dart';
import '../data/post_db_provider.dart';
import '../../user/domain/user.dart';
import '../../user/data/user_db.dart';
import '../../user/data/user_db_provider.dart';
import '../../authentication/data/logged_in_user_provider.dart';
import '../../posts/presentation/feed_post.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late UserDB userDB;
  late PostDB postDB;

  @override
  void initState() {
    super.initState();
    userDB = ref.read(userDBProvider);
    postDB = ref.read(postDBProvider);
  }

  // https://stackoverflow.com/questions/72315755/close-an-expansiontile-when-another-expansiontile-is-tapped
  int selectedTile = 0;
  int sectionCount = 3;

  List<Widget> widgetsFromEveryone(List<Post> posts) {
    return posts.map((e) => FeedPost(post: e)).toList();
  }

  Future<List<Widget>> widgetsFromOrganization(
    User? loggedInUser,
    List<Post> posts,
  ) async {
    if (loggedInUser == null) {
      return [const Text('Create an account to join an org')];
    }

    var filteredPosts = List.empty();
    Future.forEach(posts, (e) async {
      var poster = await userDB.getById(e.userId);
      if (poster != null &&
          loggedInUser.organizationId == poster.organizationId) {
        filteredPosts.add(e);
      }
    });

    return filteredPosts.map((e) => FeedPost(post: e)).toList();
  }

  Future<List<Widget>> widgetsFromFriends(
      User? loggedInUser, List<Post> posts) async {
    if (loggedInUser == null) {
      return [const Text('Create an account to add friends')];
    }

    var filteredPosts = List.empty();
    Future.forEach(posts, (e) async {
      var poster = await userDB.getById(e.userId);
      if (poster != null && loggedInUser.friendIds.contains(poster.id)) {
        filteredPosts.add(e);
      }
    });

    return filteredPosts.map((e) => FeedPost(post: e)).toList();
  }

  Future<Widget> createSectionBody(
    int index,
    User? loggedInUser,
    List<Post> posts,
  ) async {
    return switch (index) {
      0 => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: widgetsFromEveryone(
            posts,
          ),
        ),
      1 => Column(
          children: await widgetsFromOrganization(
            loggedInUser,
            posts,
          ),
        ),
      2 => Column(
          children: await widgetsFromFriends(
            loggedInUser,
            posts,
          ),
        ),
      _ => throw IndexError.withLength(
          index,
          sectionCount,
          message: 'Received an index outside defined sections.',
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    userDB = ref.watch(userDBProvider);
    postDB = ref.watch(postDBProvider);
    final loggedInUser = ref.watch(loggedInUserProvider);
    final postsFuture = postDB.getAll();

    return FutureBuilder(
      future: postsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState != ConnectionState.done) {
          return const LoadingView();
        }
        final posts = snapshot.data!;
        return switch (loggedInUser) {
          AsyncData(:final value) => ListView.builder(
              key: Key(selectedTile.toString()),
              itemCount: sectionCount,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var headerStyle = const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                );
                return ExpansionTile(
                  key: PageStorageKey(
                      'home_view_expansion_tile_$index'.hashCode),
                  initiallyExpanded: index == selectedTile,
                  title: Text(
                    switch (index) {
                      0 => 'From everyone',
                      1 => 'From your organization',
                      2 => 'From your friends',
                      _ => throw IndexError.withLength(
                          index,
                          sectionCount,
                          message:
                              'Received an index outside defined sections.',
                        ),
                    },
                    style: headerStyle,
                  ),
                  onExpansionChanged: (expanded) {
                    setState(() {
                      selectedTile = expanded ? index : -1;
                    });
                  },
                  children: [
                    FutureBuilder(
                      future: createSectionBody(index, value, posts),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return snapshot.data!;
                        }
                        return const LoadingView();
                      },
                    ),
                  ],
                );
              },
            ),
          AsyncError(:final error) => Text('Error: $error'),
          _ => const LoadingView(),
        };
      },
    );
  }
}
