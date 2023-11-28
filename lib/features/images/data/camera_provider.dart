import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera_provider.g.dart';

@riverpod
Future<CameraDescription> camera(CameraRef ref) async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  return firstCamera;
}

@riverpod
Future<Raw<CameraController>> cameraController(CameraControllerRef ref) async {
  final controller = CameraController(
    await ref.watch(cameraProvider.future),
    ResolutionPreset.medium,
    enableAudio: false,
    imageFormatGroup: ImageFormatGroup.jpeg,
  );
  ref.onDispose(() async {
    await controller.dispose();
  });
  await controller.initialize();
  return controller;
}
