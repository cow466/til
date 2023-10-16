import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:til/data/post_db.dart';
import 'package:til/data/user_db.dart';
import 'package:til/settings/sign_in.dart';
import 'package:til/views/components/feed_post.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // https://stackoverflow.com/questions/72315755/close-an-expansiontile-when-another-expansiontile-is-tapped
  int selectedTile = 0;
  int sectionCount = 3;

  List<Widget> widgetsFromEveryone() {
    return postDB.getAll().map((e) => FeedPost(post: e)).toList();
  }

  List<Widget> widgetsFromOrganization() {
    return postDB
        .getAll()
        .where((e) {
          var poster = userDB.getById(e.userId);
          return loggedInUser!.organizationId == poster.organizationId;
        })
        .map((e) => FeedPost(post: e))
        .toList();
  }

  List<Widget> widgetsFromFriends() {
    return postDB
        .getAll()
        .where((e) {
          var poster = userDB.getById(e.userId);
          return loggedInUser!.friendIds.contains(poster.id);
        })
        .map((e) => FeedPost(post: e))
        .toList();
  }

  Widget createSectionBody(int index) {
    return switch (index) {
      0 => Column(
          children: widgetsFromEveryone(),
        ),
      1 => Column(
          children: widgetsFromOrganization(),
        ),
      2 => Column(
          children: widgetsFromFriends(),
        ),
      _ => throw IndexError.withLength(index, sectionCount,
          message: 'Received an index outside defined sections.'),
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: Key(selectedTile.toString()),
      itemCount: sectionCount,
      itemBuilder: (context, index) {
        var headerStyle = const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        );
        return ExpansionTile(
          initiallyExpanded: index == selectedTile,
          title: Text(
            switch (index) {
              0 => 'From everyone',
              1 => 'From your organization',
              2 => 'From your friends',
              _ => throw IndexError.withLength(
                  index,
                  sectionCount,
                  message: 'Received an index outside defined sections.',
                ),
            },
            style: headerStyle,
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              // selectedTile = expanded ? index : -1;
            });
          },
          children: [
            createSectionBody(index),
          ],
        );
      },
    );
  }
}
