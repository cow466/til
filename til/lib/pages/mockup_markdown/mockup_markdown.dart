import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/drawer_view.dart';

class MockupMarkdownView extends StatelessWidget {
  const MockupMarkdownView({
    Key? key,
    required this.title,
    required this.data,
    required this.routeName,
  }) : super(key: key);

  final String title;
  final String data;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: Text(title),
      ),
      body: Markdown(
        data: data,
        onTapLink: (text, href, title) {
          launchUrl(Uri.parse(href ?? ""));
        },
      ),
    );
  }
}
