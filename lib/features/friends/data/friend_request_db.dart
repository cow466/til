import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:til/features/crud_collection.dart';
import 'package:til/features/user/data/user_db_provider.dart';
import '../domain/friend_request.dart';

final class FriendRequestDB extends CrudCollection<FriendRequest> {
  FriendRequestDB(this.ref)
      : super(
          collectionPath: 'friendRequests',
          fromJson: FriendRequest.fromJson,
        );

  final ProviderRef<FriendRequestDB> ref;

  Future<void> _add({required String from, required String to}) async {
    await createOne(FriendRequest(
      id: '',
      from: from,
      to: to,
      sentAt: DateTime.now(),
    ));
  }

  /// Returns true if successful
  Future<bool> sendFromTo(String from, String to) async {
    final items = await collectionRef
        .where('from', isEqualTo: from)
        .where('to', isEqualTo: to)
        .get();
    final existing = items.docs.map((e) => e.data() as FriendRequest).toList();
    if (existing.isNotEmpty) {
      return false;
    }
    _add(from: from, to: to);
    return true;
  }

  Future<List<FriendRequest>> getFromUser(DocumentId userId) async {
    return await getWhere('from', isEqualTo: userId);
  }

  Future<List<FriendRequest>> getToUser(DocumentId userId) async {
    return await getWhere('to', isEqualTo: userId);
  }

  Future<void> accept(DocumentId friendReqId) async {
    final fr = await getById(friendReqId);
    if (fr == null) {
      return;
    }
    final userDB = ref.watch(userDBProvider);
    userDB.updateOne(fr.from, {
      'friendIds': FieldValue.arrayUnion([fr.to])
    });
    userDB.updateOne(fr.to, {
      'friendIds': FieldValue.arrayUnion([fr.from])
    });
    ref.watch(userDBProvider).getById(fr.from);
    deleteOne(friendReqId);
  }
}
