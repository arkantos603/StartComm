import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/widgets/custom_bottom_app_bar.dart';
import 'package:startcomm/locator.dart';
import 'package:startcomm/features/home/home_controller.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final HomeController _homeController = locator.get<HomeController>();

  @override
  void initState() {
    super.initState();
    _homeController.pageController.addListener(() {
      log(_homeController.pageController.page.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _homeController.pageController,
        children: _homeController.pages,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedItemColor: AppColors.green,
        children: [
          CustomBottomAppBarItem(
            label: 'home',
            primaryIcon: Icons.home,
            secondaryIcon: Icons.home_outlined,
            onPressed: () => _homeController.pageController.jumpToPage(0),
          ),
          CustomBottomAppBarItem(
            label: 'caixa',
            primaryIcon: Icons.add_shopping_cart,
            secondaryIcon: Icons.add_shopping_cart_outlined,
            onPressed: () => _homeController.pageController.jumpToPage(1),
          ),
          CustomBottomAppBarItem(
            label: 'produtos',
            primaryIcon: Icons.inventory,
            secondaryIcon: Icons.inventory_2_outlined,
            onPressed: () => _homeController.pageController.jumpToPage(2),
          ),
          CustomBottomAppBarItem(
            label: 'mapa',
            primaryIcon: Icons.map,
            secondaryIcon: Icons.map_outlined,
            onPressed: () => _homeController.pageController.jumpToPage(3),
          ),
        ],
      ),
    );
  }
}