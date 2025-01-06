import 'package:flutter/material.dart';
import 'package:startcomm/features/sign_up/sign_up_page.dart';
// import 'package:startcomm/features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignUpPage(),
    );
  }
}
