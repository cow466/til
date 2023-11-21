import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:til/features/crud_collection.dart';
import '../domain/post.dart';

final class PostDB extends CrudCollection<Post> {
  PostDB(this.ref)
      : super(
          collectionPath: 'posts',
          fromJson: Post.fromJson,
        );

  final ProviderRef<PostDB> ref;
  // final List<Post> _posts = [
  //   Post(
  //     id: '0',
  //     userId: '1',
  //     content: 'the basics of Dart',
  //     postedAt: DateTime(2023, 8, 23, 21, 50, 0),
  //   ),
  //   Post(
  //     id: '1',
  //     userId: '1',
  //     content: 'how to write recursive functions in Lisp',
  //     postedAt: DateTime(2023, 9, 6, 11, 45, 0),
  //   ),
  //   Post(
  //     id: '2',
  //     userId: '2',
  //     content: 'about Polyphemus',
  //     postedAt: DateTime.now(),
  //   ),
  // ];

  Future<List<Post>> getUserPosts(String userId) async {
    return await getWhere('userId', isEqualTo: userId);
  }

  bool addPost({required String userId, required String content}) {
    createOne(Post(
      userId: userId,
      content: content,
      postedAt: DateTime.now(),
    ));
    return true;
  }
}
