import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shortid/shortid.dart';

class FriendRequest {
  FriendRequest({
    required this.id,
    required this.from,
    required this.to,
    required this.sentAt,
  });

  String id;
  String from;
  String to;
  DateTime sentAt;
}

class FriendRequestDB {
  FriendRequestDB(this.ref);

  final ProviderRef<FriendRequestDB> ref;
  void _add({required String from, required String to}) {
    String newId;
    do {
      newId = shortid.generate();
    } while (_friendRequests.any((fr) => fr.id == newId));
    _friendRequests.add(FriendRequest(
      id: newId,
      from: from,
      to: to,
      sentAt: DateTime.now(),
    ));
  }

  final List<FriendRequest> _friendRequests = [
    // FriendRequest(
    //   id: '0',
    //   from: '1',
    //   to: '2',
    //   sentAt: DateTime.now(),
    // )
  ];

  FriendRequest getById(String id) {
    return _friendRequests.firstWhere((fr) => fr.id == id);
  }

  bool sendFromTo(String from, String to) {
    if (_friendRequests.any((fr) => fr.from == from && fr.to == to)) {
      return false;
    }
    _add(from: from, to: to);
    return true;
  }

  List<FriendRequest> getFromUser(String userId) {
    return _friendRequests.where((fr) => fr.from == userId).toList();
  }

  List<FriendRequest> getToUser(String userId) {
    return _friendRequests.where((fr) => fr.to == userId).toList();
  }
}
