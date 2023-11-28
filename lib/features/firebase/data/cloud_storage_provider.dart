import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloud_storage_provider.g.dart';

@Riverpod(keepAlive: true)
FirebaseStorage cloudStorage(CloudStorageRef ref) {
  return FirebaseStorage.instance;
}
