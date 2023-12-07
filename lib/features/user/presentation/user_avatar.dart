import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:til/features/firebase/data/cloud_storage_controller.dart';
import 'package:til/features/user/domain/user.dart';

class UserAvatar extends ConsumerWidget {
  const UserAvatar({
    super.key,
    required this.user,
    this.radius,
    this.minRadius,
    this.maxRadius,
  });

  final User user;
  final double? radius;
  final double? minRadius;
  final double? maxRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImageFuture = ref
        .watch(cloudStorageControllerProvider)
        .downloadFile(pathInStorage: user.imagePath);
    final profileImageUrlFuture = ref
        .watch(cloudStorageControllerProvider)
        .getReference(user.imagePath)
        .getDownloadURL();
    return FutureBuilder(
      future: Future.wait([profileImageFuture, profileImageUrlFuture]),
      builder: (context, snapshot) {
        ImageProvider imageProvider =
            const AssetImage('assets/images/placeholder-profile.jpg');
        if (snapshot.hasData) {
          final profileImage = snapshot.data![0] as XFile?;
          final profileImageUrl = snapshot.data![1] as String;
          if (kIsWeb) {
            imageProvider = NetworkImage(profileImageUrl);
          } else if (profileImage != null) {
            imageProvider = NetworkImage(profileImageUrl);
            // imageProvider = FileImage(File(profileImage.path));
          }
        }
        return Tooltip(
          message: user.name,
          child: CircleAvatar(
            radius: radius,
            minRadius: minRadius,
            maxRadius: maxRadius,
            backgroundImage: imageProvider,
          ),
        );
      },
    );
  }
}
