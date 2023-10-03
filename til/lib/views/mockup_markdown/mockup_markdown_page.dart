import 'package:flutter/material.dart';

import './mockup_markdown.dart';

abstract class MockupMarkdownPage extends MockupMarkdownView {
  const MockupMarkdownPage({
    Key? key,
    required String title,
    required String data,
    required this.routeName,
  }) : super(key: key, title: title, data: data);

  final String routeName;
}
