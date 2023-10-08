import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:til/views/layouts/main_layout/main_page_layout.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({super.key});

  static const routeName = '/new-post';

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  // https://stackoverflow.com/questions/72315755/close-an-expansiontile-when-another-expansiontile-is-tapped
  int selectedTile = -1;
  int sectionCount = 3;

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
