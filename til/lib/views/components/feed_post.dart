import 'package:flutter/material.dart';
import 'package:til/data/post_db.dart';
import 'package:til/data/user_db.dart';
import 'package:til/helpers/time_format.dart';

class FeedPost extends StatelessWidget {
  const FeedPost({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final poster = userDB.getById(post.userId);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/${poster.imagePath}'),
            maxRadius: 30,
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Text(
                poster.email,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                post.content,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}