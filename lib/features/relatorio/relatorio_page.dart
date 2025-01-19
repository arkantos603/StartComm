import 'package:flutter/material.dart';

class RelatorioPage extends StatefulWidget {
  const RelatorioPage({super.key});

  @override
  State<RelatorioPage> createState() => _RelatorioPageState();
}

class _RelatorioPageState extends State<RelatorioPage> 
    with AutomaticKeepAliveClientMixin<RelatorioPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(
      body: Center(
        child: Text('Relatorio'),
      ),
    );
  }
}
