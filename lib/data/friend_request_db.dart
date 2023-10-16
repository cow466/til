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
  final List<FriendRequest> _friendRequests = [
    FriendRequest(
      id: '0',
      from: '1',
      to: '2',
      sentAt: DateTime.now(),
    )
  ];

  FriendRequest getById(String id) {
    return _friendRequests.firstWhere((fr) => fr.id == id);
  }

  List<FriendRequest> getFromUser(String userId) {
    return _friendRequests.where((fr) => fr.from == userId).toList();
  }

  List<FriendRequest> getToUser(String userId) {
    return _friendRequests.where((fr) => fr.to == userId).toList();
  }
}

FriendRequestDB friendRequestDB = FriendRequestDB();
