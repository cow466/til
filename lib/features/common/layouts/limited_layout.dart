import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../posts/presentation/home_view.dart';
import '../../authentication/presentation/sign_in_view.dart';
import '../../error/presentation/page_not_found_view.dart';

class LimitedPageLayout extends StatefulWidget {
  const LimitedPageLayout({
    super.key,
    required this.body,
  });

  static const routeName = '/limit';

  final Widget body;

  @override
  State<LimitedPageLayout> createState() => _LimitedPageLayoutState();
}

class _LimitedPageLayoutState extends State<LimitedPageLayout> {
  bool bottomSelected = true;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today I Learned'),
        centerTitle: true,
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
              0 => LimitedPageLayout.routeName + HomeView.routeName,
              1 => LimitedPageLayout.routeName + SignInView.routeName,
              _ => LimitedPageLayout.routeName + PageNotFoundView.routeName,
            },
          );
        },
        selectedIndex: pageIndex,
        indicatorColor: bottomSelected ? null : Colors.transparent,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.login,
              size: 30,
            ),
            label: 'Sign In',
          ),
        ],
      ),
      body: widget.body,
    );
  }
}
