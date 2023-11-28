import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:shortid/shortid.dart';
import 'package:til/features/authentication/data/auth_controller_provider.dart';
import 'package:til/features/firebase/data/cloud_storage_controller.dart';
import 'package:til/features/firebase/data/firebase_auth_provider.dart';
import 'package:til/features/images/presentation/crop_image_screen.dart';
import 'package:til/features/images/presentation/take_picture_screen.dart';
import 'package:til/features/posts/presentation/home_view.dart';
import 'package:til/features/user/domain/user.dart';
import '../../user/data/user_db.dart';
import '../../user/data/user_db_provider.dart';
import '../../authentication/data/logged_in_user_provider.dart';

/// Presents the page containing fields to signup with a username and password, plus buttons.
class CreateAccountView extends ConsumerStatefulWidget {
  const CreateAccountView({
    super.key,
    this.step,
    this.role,
    this.imagePath,
  });

  static const routeName = '/create-account';

  final int? step;
  final Role? role;
  final String? imagePath;

  @override
  ConsumerState<CreateAccountView> createState() => CreateAccountViewState();
}

class CreateAccountViewState extends ConsumerState<CreateAccountView> {
  Role? _role;
  final _nameController = TextEditingController();
  final _aboutMeController = TextEditingController();
  final _orgNameController = TextEditingController();
  final _orgAdminNameController = TextEditingController.fromValue(
      const TextEditingValue(text: 'MyOrgAdmin'));
  final _orgAdminAboutMeController = TextEditingController();
  final _orgAdminImageController = TextEditingController();
  final _orgBannerImageController = TextEditingController();
  final _orgLogoImageController = TextEditingController();

  late UserDB userDB;

  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.step ?? 0;
    _role = widget.role;
    userDB = ref.read(userDBProvider);
  }

  StepState _calcStepState(int stepIdx) {
    if (stepIdx < _index) {
      return StepState.complete;
    } else if (stepIdx == _index) {
      return StepState.editing;
    } else {
      return StepState.indexed;
    }
  }

  final generalTextStyle = const TextStyle(
    fontSize: 20.0,
  );

  // User role
  Step _buildStepOne() {
    return Step(
      title: const Text('Role'),
      content: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: (() {
              String message = 'You are a${switch (_role) {
                Role.user => ' learner!',
                Role.organizationAdmin => 'n organization admin!',
                _ => '...',
              }}';
              return Text(
                message,
                style: generalTextStyle,
              );
            })(),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _role = Role.user;
                  });
                },
                child: const Text('I am a learner'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _role = Role.organizationAdmin;
                  });
                },
                child: const Text('I am an organization admin'),
              ),
            ],
          )
        ],
      ),
      state: _calcStepState(0),
    );
  }

  // User info
  Step _buildStepTwo() {
    return Step(
      title: const Text('Info'),
      content: Container(
        alignment: Alignment.centerLeft,
        child: switch (_role) {
          Role.user => Column(
              children: [
                Text(
                  'Some info about you',
                  style: generalTextStyle,
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: _aboutMeController,
                  decoration: const InputDecoration(
                    labelText: 'About Me',
                  ),
                ),
              ],
            ),
          Role.organizationAdmin => Column(
              children: [
                Text(
                  'Some info about the organization',
                  style: generalTextStyle,
                ),
                TextField(
                  controller: _orgNameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: _aboutMeController,
                  decoration: const InputDecoration(
                    labelText: 'About Me',
                  ),
                ),
              ],
            ),
          _ => Column(
              children: [
                Text(
                  'Complete step one first',
                  style: generalTextStyle,
                )
              ],
            ),
        },
      ),
      state: _calcStepState(1),
    );
  }

  void _uploadImage() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((file) {
      if (file != null) {
        GoRouter.of(context).push(CropImageScreen.routeName, extra: file);
      }
    });
  }

  // Image upload
  Step _buildStepThree() {
    return Step(
      title: const Text('Upload Image'),
      content: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Column(
              children: widget.imagePath != null
                  ? [
                      const Text('Preview image'),
                      kIsWeb
                          ? Image.network(
                              widget.imagePath!,
                              width: 200.0,
                            )
                          : Image.file(
                              File(widget.imagePath!),
                              width: 200.0,
                            ),
                    ]
                  : [
                      Image.asset(
                        'images/placeholder-profile.jpg',
                        width: 200.0,
                      ),
                    ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).push(TakePictureScreen.routeName);
                  },
                  child: const Text('Take Picture'),
                ),
                TextButton(
                  onPressed: _uploadImage,
                  child: const Text('Pick From Gallery'),
                ),
              ],
            )
          ],
        ),
      ),
      state: _calcStepState(2),
    );
  }

  void signUp() async {
    print('----------------------------sign up');
    switch (_role) {
      case Role.user:
        // https://stackoverflow.com/questions/69078404/how-to-convert-png-image-to-jpg-format-in-flutter
        if (widget.imagePath == null) return;
        final fileName = '${shortid.generate()}.jpg';
        final image =
            img.decodeImage(await XFile(widget.imagePath!).readAsBytes());
        if (image == null) return;
        image.backgroundColor = img.ColorRgb8(255, 255, 255);
        final XFile file = XFile(fileName, bytes: img.encodeJpg(image));
        ref.watch(cloudStorageControllerProvider).uploadFile(
              dir: Dir.images,
              fileName: fileName,
              file: file,
              metadata: SettableMetadata(contentType: 'image/jpeg'),
              onSuccess: (fileRef) {
                print('------------------success');
                print(fileRef);
                ref
                    .read(authControllerProvider.notifier)
                    .registerUser(
                      name: _nameController.text,
                      email:
                          ref.watch(firebaseAuthProvider).currentUser!.email!,
                      aboutMe: _aboutMeController.text,
                      imagePath: fileRef.fullPath,
                      ref: ref,
                    )
                    .then((_) {
                  context.go(HomeView.routeName);
                });
              },
              onError: (error) {
                print('---------------------error');
                print(error);
              },
            );
      case Role.organizationAdmin:
        ref
            .read(authControllerProvider.notifier)
            .registerOrgAdmin(
              name: _orgNameController.text,
              bannerImage: _orgBannerImageController.text,
              logoImage: _orgLogoImageController.text,
              accountName: _orgAdminNameController.text,
              accountAboutMe: _orgAdminAboutMeController.text,
              accountImagePath: _orgAdminImageController.text,
              ref: ref,
            )
            .then((_) {
          context.go(HomeView.routeName);
        });
      default:
    }
  }

  // Finalize
  Step _buildStepFour() {
    return Step(
      title: const Text('Finalize'),
      content: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: signUp,
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
      state: _calcStepState(1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today I Learned'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 40.0),
          Image.asset('images/til_logo.png', width: 125),
          const SizedBox(height: 16.0),
          Text(
            'Finish Creating Your Account',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Stepper(
                currentStep: _index,
                type: StepperType.horizontal,
                elevation: 0.0,
                onStepCancel: () {
                  if (_index > 0) {
                    setState(() {
                      _index -= 1;
                    });
                  } else {
                    ref.watch(firebaseAuthProvider).currentUser!.delete();
                    GoRouter.of(context).pop();
                  }
                },
                onStepContinue: () {
                  if (_role != null && _index <= 3) {
                    setState(() {
                      _index += 1;
                    });
                  }
                },
                onStepTapped: (int index) {
                  if (_role != null) {
                    setState(() {
                      _index = index;
                    });
                  }
                },
                steps: <Step>[
                  _buildStepOne(),
                  _buildStepTwo(),
                  _buildStepThree(),
                  _buildStepFour(),
                ],
                controlsBuilder: (context, details) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 48.0),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: details.onStepCancel,
                          child: Text(_index == 0 ? 'CANCEL' : 'BACK'),
                        ),
                        if (_index < 3)
                          TextButton(
                            onPressed: details.onStepContinue,
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('NEXT'),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
