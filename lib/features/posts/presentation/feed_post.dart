import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:til/features/loading/presentation/loading_view.dart';
import 'package:til/features/user/domain/user.dart';
import 'package:til/features/user/presentation/user_avatar.dart';
import '../domain/post.dart';
import '../../user/data/user_db_provider.dart';
import '../../common/time_format.dart';
import '../../user/presentation/other_profile_view.dart';

class FeedPost extends ConsumerWidget {
  const FeedPost({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<User?> poster = ref.watch(userDBProvider).getById(post.userId);

    return FutureBuilder(
      future: poster,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final poster = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () {
                    context.go(
                      OtherProfileView.routeName.replaceFirst(':id', poster.id),
                    );
                  },
                  child: UserAvatar(
                    user: poster,
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
                            poster.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            formatTime(post.postedAt),
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      // Email
                      Text(
                        poster.email,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      // Thing learned
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            const TextSpan(
                              text: 'TIL',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: ' ${post.content}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
