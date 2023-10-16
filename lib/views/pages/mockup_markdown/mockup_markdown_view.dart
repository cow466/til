import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class MockupMarkdownView extends StatelessWidget {
  const MockupMarkdownView({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: data,
      onTapLink: (text, href, title) {
        launchUrl(Uri.parse(href ?? ""));
      },
    );
  }
}
