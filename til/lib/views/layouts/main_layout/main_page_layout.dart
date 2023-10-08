import 'package:flutter/material.dart';
import 'package:til/views/components/drawer_view.dart';
import 'package:til/views/pages/home/home_view.dart';
import 'package:til/views/pages/new_post/new_post_view.dart';
import 'package:til/views/pages/page_not_found/page_not_found_view.dart';

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
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: const Text("Today I Learned"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              currentPageIndex = 100;
            });
          },
          icon: const Icon(
            Icons.person,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                currentPageIndex = 101;
              });
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          )
        ],
      ),
      // https://api.flutter.dev/flutter/material/NavigationBar-class.html
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_outlined),
            label: 'Add New',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            label: 'School',
          ),
        ],
      ),
      body: switch (currentPageIndex) {
        0 => const HomeView(),
        1 => const NewPostView(),
        _ => const PageNotFoundView(),
      },
    );
  }
}
