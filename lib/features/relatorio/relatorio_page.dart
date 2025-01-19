import 'package:flutter/material.dart';

class RelatorioPage extends StatelessWidget {
  const RelatorioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Relatórios'),
          ],
        ),
      ),
    );
  }
}