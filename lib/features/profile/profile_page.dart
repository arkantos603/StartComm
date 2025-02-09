import 'package:flutter/material.dart';
import 'package:startcomm/locator.dart';
import 'package:startcomm/services/auth_services.dart';
import 'package:startcomm/services/secure_storage.dart';
import 'package:startcomm/common/widgets/custom_app_bar.dart'; // Importar o CustomAppBar

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
      appBar: const CustomAppBar(title: 'Perfil'), // Usar o CustomAppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Perfil'),
            TextButton(
              onPressed: () async {
                await locator.get<AuthService>().signOut();
                await const SecureStorage().deleteAll();
                if (!context.mounted) return;
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Deslogar-se'),
            ),
          ],
        ),
      ),
    );
  }
}