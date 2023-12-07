import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:til/features/user/domain/user.dart';
import 'package:til/features/user/presentation/user_avatar.dart';
import '../../user/presentation/other_profile_view.dart';

class SuggestedPerson extends ConsumerWidget {
  const SuggestedPerson({
    super.key,
    required this.user,
    required this.message,
  });

  final User user;
  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and date
                Row(
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // Email
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                // Message
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
