import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:til/views/pages/friends/friends_view.dart';
import 'package:til/views/pages/home/home_view.dart';
import 'package:til/views/pages/new_post/new_post_view.dart';
import 'package:til/views/pages/page_not_found/page_not_found_view.dart';
import 'package:til/views/pages/profile/profile_view.dart';

class MainPageLayout extends StatefulWidget {
  const MainPageLayout({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  State<MainPageLayout> createState() => _MainPageLayoutState();
}

class _MainPageLayoutState extends State<MainPageLayout> {
  bool bottomSelected = true;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today I Learned'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            bottomSelected = false;
            context.go(ProfileView.routeName);
          },
          icon: const Icon(
            Icons.person,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              bottomSelected = false;
              context.go('/settings');
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (value) {
          setState(() {
            pageIndex = value;
            bottomSelected = true;
          });
          context.go(
            switch (value) {
              0 => HomeView.routeName,
              1 => NewPostView.routeName,
              2 => FriendsView.routeName,
              _ => PageNotFoundView.routeName,
            },
          );
        },
        selectedIndex: pageIndex,
        indicatorColor: bottomSelected ? null : Colors.transparent,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.question_answer_outlined,
              size: 30,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.add_outlined,
              size: 30,
            ),
            label: 'New Post',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.people_outlined,
              size: 30,
            ),
            label: 'Friends',
          ),
        ],
      ),
      body: widget.body,
    );
  }
}
