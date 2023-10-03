import '../mockup_markdown/mockup_markdown.dart';

const bugHandlerEmail = 'cow@hawaii.edu';

const pageSpecification = '''
# Oops!

How did you get here?

[Submit a bug ticket](mailto:cow@hawaii.edu)
''';

class PageNotFoundView extends MockupMarkdownView {
  const PageNotFoundView({super.key})
      : super(
          title: "Page Not Found",
          data: pageSpecification,
          routeName: "/page-not-found",
        );
}
