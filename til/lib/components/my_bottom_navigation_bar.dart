import 'package:flutter/material.dart';

class MyBottomNavigationBar extends NavigationBar {
  MyBottomNavigationBar({super.key})
      : super(
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            NavigationDestination(
              icon: Icon(Icons.school_outlined),
              label: 'School',
            ),
          ],
        );
}
