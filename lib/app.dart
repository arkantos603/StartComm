import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/routs.dart';
import 'package:startcomm/features/caixa/caixa_page.dart';
import 'package:startcomm/features/home/home_page_view.dart';
// import 'package:startcomm/features/map/map_page.dart';
import 'package:startcomm/features/onboarding/onboarding_page.dart';
import 'package:startcomm/features/products/products_page.dart';
import 'package:startcomm/features/relatorio/relatorio_page.dart';
import 'package:startcomm/features/sign_in/sign_in._page.dart';
import 'package:startcomm/features/sign_up/sign_up_page.dart';
import 'package:startcomm/features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NamedRoute.splash,
      routes: {
        NamedRoute.initial: (context) => const OnboardingPage(),
        NamedRoute.splash: (context) => const SplashPage(),
        NamedRoute.signUp: (context) => const SignUpPage(),
        NamedRoute.signIn: (context) => const SignInPage(),
        NamedRoute.home: (context) => const HomePageView(),
        NamedRoute.caixa: (context) => const CaixaPage(),
        NamedRoute.relatorio: (context) => const RelatorioPage(),
        // NamedRoute.profile: (context) => const ProfilePage(),
        NamedRoute.produtos: (context) => const ProductsPage(),
        // NamedRoute.lucros: (context) => const LucrosPage(),
        // NamedRoute.despesas: (context) => const DespesasPage(),
        // NamedRoute.mapa: (context) => const MapPage(),
      },
    );
  }
}
