// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cameraHash() => r'6df11bc4149b10eb959ffba891311e358a6f1570';

/// See also [camera].
@ProviderFor(camera)
final cameraProvider = AutoDisposeFutureProvider<CameraDescription>.internal(
  camera,
  name: r'cameraProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cameraHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CameraRef = AutoDisposeFutureProviderRef<CameraDescription>;
String _$cameraControllerHash() => r'd201abe924d8b18cbf11e64cb950ba8e8c07cb1c';

/// See also [cameraController].
@ProviderFor(cameraController)
final cameraControllerProvider =
    AutoDisposeFutureProvider<Raw<CameraController>>.internal(
  cameraController,
  name: r'cameraControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cameraControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CameraControllerRef
    = AutoDisposeFutureProviderRef<Raw<CameraController>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
