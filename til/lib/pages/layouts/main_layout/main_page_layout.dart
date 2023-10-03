import 'package:flutter/material.dart';
import 'package:til/components/drawer_view.dart';
import 'package:til/components/my_app_bar.dart';
import 'package:til/components/my_bottom_navigation_bar.dart';

class MainPageLayout extends StatelessWidget {
  const MainPageLayout({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerView(),
      appBar: MyAppBar(),
      // https://api.flutter.dev/flutter/material/NavigationBar-class.html
      bottomNavigationBar: MyBottomNavigationBar(),
      body: body,
    );
  }
}
