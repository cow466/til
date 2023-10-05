import 'package:flutter/material.dart';
import 'package:til/components/drawer_view.dart';
import 'package:til/components/my_app_bar.dart';
import 'package:til/components/my_bottom_navigation_bar.dart';

class MainPageLayout extends StatefulWidget {
  const MainPageLayout({
    super.key,
    required this.title,
    required this.body,
  });

  final Widget title;
  final Widget body;

  @override
  State<MainPageLayout> createState() => _MainPageLayoutState();
}

class _MainPageLayoutState extends State<MainPageLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerView(),
      appBar: MyAppBar(title: widget.title),
      // https://api.flutter.dev/flutter/material/NavigationBar-class.html
      bottomNavigationBar: MyBottomNavigationBar(),
      body: widget.body,
    );
  }
}
