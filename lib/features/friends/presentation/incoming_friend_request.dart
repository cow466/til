import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:til/features/friends/data/friend_request_db_provider.dart';
import 'package:til/features/friends/domain/friend_request.dart';
import 'package:til/features/loading/presentation/loading_view.dart';
import 'package:til/features/user/data/user_db_provider.dart';
import 'package:til/features/user/presentation/user_avatar.dart';
import '../../user/presentation/other_profile_view.dart';

class IncomingFriendRequest extends ConsumerWidget {
  const IncomingFriendRequest({
    super.key,
    required this.friendRequest,
  });

  final FriendRequest friendRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFuture = ref.watch(userDBProvider).getById(friendRequest.from);
    return FutureBuilder(
      future: userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () {
                    context.go(
                      OtherProfileView.routeName.replaceFirst(':id', user.id),
                    );
                  },
                  child: UserAvatar(
                    user: user,
                    maxRadius: 30.0,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ref
                            .watch(friendRequestDBProvider)
                            .accept(friendRequest.id);
                      },
                      icon: const Icon(Icons.check),
                      splashRadius: 15.0,
                      tooltip: 'Accept',
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .watch(friendRequestDBProvider)
                            .ignore(friendRequest.id);
                      },
                      icon: const Icon(Icons.close),
                      splashRadius: 15.0,
                      tooltip: 'Ignore',
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return const LoadingView();
      },
    );
  }
}
