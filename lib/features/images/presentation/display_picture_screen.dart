import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:til/features/images/presentation/crop_image_screen.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  static const routeName = '/display-picture';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      floatingActionButton: TextButton(
        onPressed: () {
          GoRouter.of(context).pushReplacement(CropImageScreen.routeName,
              extra: XFile(imagePath));
        },
        child: const Text('Crop'),
      ),
      body: kIsWeb ? Image.network(imagePath) : Image.file(File(imagePath)),
    );
  }
}
