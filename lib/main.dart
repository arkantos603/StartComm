import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:startcomm/firebase_options.dart';
import 'package:startcomm/locator.dart';
import 'package:startcomm/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencies();
  runApp(const App());
}