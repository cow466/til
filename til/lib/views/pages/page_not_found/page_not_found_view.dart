import 'package:flutter/material.dart';

import '../mockup_markdown/mockup_markdown_view.dart';

const bugHandlerEmail = 'cow@hawaii.edu';

const pageSpecification = '''
# Oops!

How did you get here?

[Submit a bug ticket](mailto:cow@hawaii.edu)
''';

class PageNotFoundView extends StatelessWidget {
  const PageNotFoundView({super.key});

  static const routeName = "/page-not-found";

  @override
  Widget build(BuildContext context) {
    return const MockupMarkdownView(data: pageSpecification);
  }
}
