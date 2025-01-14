import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/routs.dart';
import 'package:startcomm/services/secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _secureStorage = const SecureStorageService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
            ElevatedButton(
              onPressed: () {
                _secureStorage.deleteOne(key: 'CURRENT_USER').then(
                      (_) =>                 
                          Navigator.popAndPushNamed(
                          // ignore: use_build_context_synchronously
                            context,
                            NamedRoute.splash
                  ),
                );
              },
              child: const Text('Deslogar'),
            ),
          ],
        ),
      ),
    );
  }
}
