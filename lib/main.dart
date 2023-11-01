import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:til/settings/sign_in.dart';
import 'package:til/app.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: TILApp(),
    ),
  );
}
