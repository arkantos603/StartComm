import 'package:flutter/material.dart';

class CaixaPage extends StatelessWidget {
  const CaixaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Caixa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Gerenciar Caixa'),
          ],
        ),
      ),
    );
  }
}