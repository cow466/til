import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:til/features/images/data/camera_provider.dart';
import 'package:til/features/images/presentation/crop_image_screen.dart';
import 'package:til/features/images/presentation/display_picture_screen.dart';
import 'package:til/features/loading/presentation/loading_view.dart';

class TakePictureScreen extends ConsumerStatefulWidget {
  const TakePictureScreen({
    super.key,
  });

  static const routeName = '/take-picture';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      TakePictureScreenState();
}

class TakePictureScreenState extends ConsumerState<TakePictureScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(cameraControllerProvider);
    return switch (controller) {
      AsyncData(:final value) => Scaffold(
          // backgroundColor: Colors.black,
          appBar: AppBar(title: const Text('Take a picture')),
          body: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 700.0,
              ),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CameraPreview(value),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            // Provide an onPressed callback.
            onPressed: () async {
              // Take the Picture in a try / catch block. If anything goes wrong,
              // catch the error.
              try {
                // Ensure that the camera is initialized.

                // Attempt to take a picture and then get the location
                // where the image file is saved.
                final image = await controller.asData!.value.takePicture();

                if (!mounted) return;

                // await GoRouter.of(context)
                //     .push(DisplayPictureScreen.routeName, extra: image.path);
                GoRouter.of(context)
                    .push(CropImageScreen.routeName, extra: XFile(image.path));
              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
            child: const Icon(Icons.camera_alt),
          ),
        ),
      _ => const LoadingView(),
    };
  }
}
