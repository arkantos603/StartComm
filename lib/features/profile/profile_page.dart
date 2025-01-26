import 'package:flutter/material.dart';
import 'package:startcomm/locator.dart';
import 'package:startcomm/services/auth_services.dart';
import 'package:startcomm/services/secure_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Perfil'),
        TextButton(
          onPressed: () async {
            await locator.get<AuthService>().signOut();
            await const SecureStorageService().deleteAll();
            if (!context.mounted) return;
            Navigator.popUntil(context, ModalRoute.withName('/splash'));
          },
          child: const Text('Deslogar-se'),
        )
      ])),
    );
  }
}
