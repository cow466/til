import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // https://stackoverflow.com/questions/72315755/close-an-expansiontile-when-another-expansiontile-is-tapped
  int selectedTile = -1;
  int sectionCount = 3;

  Widget createSectionBody(int index) {
    return switch (index) {
      0 => Text('From everyone'),
      1 => Text('From your university'),
      2 => Text('From your friends'),
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
        return ExpansionTile(
          initiallyExpanded: index == selectedTile,
          title: Text(switch (index) {
            0 => 'From everyone',
            1 => 'From your university',
            2 => 'From your friends',
            _ => throw IndexError.withLength(index, sectionCount,
                message: 'Received an index outside defined sections.'),
          }),
          onExpansionChanged: (expanded) {
            setState(() {
              selectedTile = expanded ? index : -1;
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
