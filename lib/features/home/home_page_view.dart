import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/widgets/custom_bottom_app_bar.dart';
import 'package:startcomm/features/caixa/caixa_page.dart';
import 'package:startcomm/features/home/home_page.dart';
import 'package:startcomm/features/map/map_page.dart';
import 'package:startcomm/features/produtos/produtos_page.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      log(pageController.page.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomePage(),
          CaixaPage(),
          ProdutosPage(),
          MapPage(),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedItemColor: AppColors.green,
        children: [
          CustomBottomAppBarItem(
            label: 'home',
            primaryIcon: Icons.home,
            secondaryIcon: Icons.home_outlined,
            onPressed: () => pageController.jumpToPage(0),
          ),
          CustomBottomAppBarItem(
            label: 'caixa',
            primaryIcon: Icons.shopping_cart,
            secondaryIcon: Icons.shopping_cart_outlined,
            onPressed: () => pageController.jumpToPage(1),
          ),
          CustomBottomAppBarItem(
            label: 'produtos',
            primaryIcon: Icons.inventory,
            secondaryIcon: Icons.inventory_2_outlined,
            onPressed: () => pageController.jumpToPage(2),
          ),
          CustomBottomAppBarItem(
            label: 'mapa',
            primaryIcon: Icons.map,
            secondaryIcon: Icons.map_outlined,
            onPressed: () => pageController.jumpToPage(3),
          ),
        ],
      ),
    );
  }
}