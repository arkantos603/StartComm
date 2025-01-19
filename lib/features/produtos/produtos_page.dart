import 'package:flutter/material.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> 
    with AutomaticKeepAliveClientMixin<ProdutosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(
      body: Center(
        child: Text('Produtos'),
      ),
    );
  }
}
