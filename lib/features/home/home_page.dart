import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_texts.dart';
import 'package:startcomm/common/constants/routs.dart';
import 'package:startcomm/features/caixa/caixa_page.dart';
import 'package:startcomm/features/relatorio/relatorio_page.dart';
import 'package:startcomm/services/secure_storage.dart';
import 'package:startcomm/common/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _secureStorage = const SecureStorageService();
  int _currentPageIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text('Home Page'),
    ),
    CaixaPage(),
    RelatorioPage(),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _currentPageIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home Page',
          style: AppTextsStyles.mediumText20.copyWith(
            color: AppColors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.greenGradient,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.greenGradient,
                ),
              ),
              child: Text(
                'Menu',
                style: AppTextsStyles.mediumText30.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Meus produtos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text('Verificar lucros'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Verificar ou adicionar despesas'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Mapa de distribuidores'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Deslogar'),
              onTap: () {
                _secureStorage.deleteOne(key: 'CURRENT_USER').then(
                      (_) =>                 
                          Navigator.popAndPushNamed(
                          // ignore: use_build_context_synchronously
                            context,
                            NamedRoute.splash
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_currentPageIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.greenGradient,
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          indicatorColor: AppColors.luzverde1,
          selectedIndex: _currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: 'Gerenciar Caixa',
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart),
              label: 'Relatórios',
            ),
          ],
        ),
      ),
    );
  }
}