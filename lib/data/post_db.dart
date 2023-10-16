class Post {
  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.postedAt,
  });

  String id;
  String userId;
  String content;
  DateTime postedAt;
}

class PostDB {
  final List<Post> _posts = [
    Post(
      id: '0',
      userId: '1',
      content: 'the basics of Dart',
      postedAt: DateTime(2023, 8, 23, 21, 50, 0),
    ),
    Post(
      id: '1',
      userId: '1',
      content: 'how to write recursive functions in Lisp',
      postedAt: DateTime(2023, 9, 6, 11, 45, 0),
    ),
    Post(
      id: '2',
      userId: '2',
      content: 'about Polyphemus',
      postedAt: DateTime.now(),
    ),
  ];

  Post getById(String id) {
    return _posts.firstWhere((post) => post.id == id);
  }

  List<Post> getAll() {
    return _posts..sort((a, b) => b.postedAt.compareTo(a.postedAt));
  }

  List<Post> getUserPosts(String userId) {
    return getAll().where((post) => post.userId == userId).toList();
  }
}

PostDB postDB = PostDB();
