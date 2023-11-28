import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:til/features/firebase/data/cloud_storage_provider.dart';

part 'cloud_storage_controller.g.dart';

typedef UploadOnSuccessCallback = void Function(Reference fileRef);
typedef OnErrorCallback = void Function(Exception error);

class CloudStorageController {
  final ProviderRef<CloudStorageController> ref;

  CloudStorageController(this.ref);

  void uploadFile({
    required Dir dir,
    required String fileName,
    required XFile file,
    required SettableMetadata metadata,
    UploadOnSuccessCallback? onSuccess,
    OnErrorCallback? onError,
  }) async {
    final storageRef = ref.watch(cloudStorageProvider).ref();
    final fileRef = storageRef.child('${dir.name}/$fileName');
    final uploadTask = fileRef.putData(await file.readAsBytes(), metadata);
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          // final progress =
          //     100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          // print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          break;
        case TaskState.canceled:
          break;
        case TaskState.error:
          if (onError != null) {
            onError(Exception(
                'Firebase Cloud Storage: Failed to upload file $fileName'));
          }
          break;
        case TaskState.success:
          if (onSuccess != null) onSuccess(fileRef);
          break;
      }
    });
  }

  Future<XFile?> downloadFile({
    required String pathInStorage,
    OnErrorCallback? onError,
  }) async {
    final storageRef = ref.watch(cloudStorageProvider).ref();
    final fileRef = storageRef.child(pathInStorage);
    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await fileRef.getData(oneMegabyte);
      if (data == null) return null;
      return XFile.fromData(data, name: 'temp-${fileRef.name}');
    } on FirebaseException catch (e) {
      if (onError != null) onError(e);
      return null;
    }
  }

  Reference getReference(String pathInStorage) {
    final storageRef = ref.watch(cloudStorageProvider).ref();
    return storageRef.child(pathInStorage);
  }
}

enum Dir {
  images,
}

@Riverpod(keepAlive: true)
CloudStorageController cloudStorageController(CloudStorageControllerRef ref) {
  return CloudStorageController(ref);
}
