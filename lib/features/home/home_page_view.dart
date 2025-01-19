// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:startcomm/features/caixa/caixa_page.dart';
// import 'package:startcomm/features/home/home_page.dart';
// import 'package:startcomm/features/relatorio/relatorio_page.dart';

// class HomePageView extends StatefulWidget {
//   const HomePageView({super.key});

//   @override
//   State<HomePageView> createState() => _HomePageViewState();
// }

// class _HomePageViewState extends State<HomePageView> {
//   final PageController = PageController();

//   @override
//   void initState() {
//     super.initState();
//     PageController.addListener(() {
//       log(PageController.page.toString());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Home Page'),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.green,
//                 Colors.greenAccent,
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: PageView(
//         controller: PageController,
//         children: const [
//           HomePage(),
//           CaixaPage(),
//           RelatorioPage(),
//         ],
//       ),
      

  
// }
