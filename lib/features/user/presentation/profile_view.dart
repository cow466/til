import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:til/features/loading/presentation/loading_view.dart';
import 'package:til/features/posts/domain/post.dart';

import '../../organization/data/organization_db.dart';
import '../../organization/data/organization_db_provider.dart';
import '../../posts/data/post_db.dart';
import '../../posts/data/post_db_provider.dart';
import '../domain/user.dart';
import '../../authentication/data/logged_in_user_provider.dart';
import '../../posts/presentation/feed_post.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  static const routeName = '/profile';

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late OrganizationDB organizationDB;

  @override
  void initState() {
    super.initState();
    organizationDB = ref.read(organizationDBProvider);
  }

  final headerStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  Widget createHeaderSection(User loggedInUser) {
    Widget createTitleBody({required String title, required String body}) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: headerStyle,
            ),
            Text(
              body,
              style: const TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      );
    }

    Widget createEmailSection({required String email}) {
      String emailStatus = 'Email verified';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            email,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            emailStatus,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.lightBlue,
            ),
          ),
        ],
      );
    }

    var name = loggedInUser.name;
    var organization = organizationDB.getById(loggedInUser.organizationId).name;
    var email = loggedInUser.email;

    return Row(
      children: [
        CircleAvatar(
          minRadius: 75,
          backgroundImage:
              AssetImage('assets/images/${loggedInUser.imagePath}'),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createTitleBody(
              title: 'Name',
              body: name,
            ),
            createTitleBody(
              title: 'Organization',
              body: organization,
            ),
            createEmailSection(
              email: email,
            ),
          ],
        ),
      ],
    );
  }

  Widget createAboutMeSection(User loggedInUser) {
    var aboutMe = loggedInUser.aboutMe;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About me',
          style: headerStyle,
        ),
        Text(
          aboutMe,
        ),
      ],
    );
  }

  Widget createThingsYouLearnedSection(
    User loggedInUser,
    List<Post> thingsLearned,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Some things you learned',
          style: headerStyle,
        ),
        Column(
          children: thingsLearned
              .map((e) => Container(
                    margin: const EdgeInsets.only(
                      top: 12,
                    ),
                    child: FeedPost(post: e),
                  ))
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUserAsync = ref.watch(loggedInUserProvider);

    if (loggedInUserAsync is AsyncData) {
      final loggedInUser = loggedInUserAsync.asData!.value!;
      final thingsLearnedFuture =
          ref.watch(postDBProvider).getUserPosts(loggedInUser.id);

      return FutureBuilder(
        future: thingsLearnedFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState != ConnectionState.done) {
            return const LoadingView();
          }
          final thingsLearned = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              children: [
                createHeaderSection(loggedInUser),
                const SizedBox(
                  height: 32,
                ),
                createAboutMeSection(loggedInUser),
                const SizedBox(
                  height: 32,
                ),
                createThingsYouLearnedSection(
                  loggedInUser,
                  thingsLearned,
                ),
              ],
            ),
          );
        },
      );
    } else {
      return const LoadingView();
    }
  }
}
