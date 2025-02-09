import 'package:flutter/material.dart';
import 'package:startcomm/locator.dart';
import 'package:startcomm/services/auth_services.dart';
import 'package:startcomm/services/secure_storage.dart';
import 'package:startcomm/common/constants/app_colors.dart'; // Importar as cores

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
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: AppColors.greenTwo, // Definir a cor do AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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