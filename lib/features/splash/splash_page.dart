import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/constants/app_texts.dart';
import 'package:startcomm/common/constants/routs.dart';
import 'package:startcomm/common/extensions/sizes.dart';
import 'package:startcomm/common/widgets/custom_circular_progress_indicator.dart';
import 'package:startcomm/features/splash/splash_controller.dart';
import 'package:startcomm/features/splash/splash_state.dart';
import 'package:startcomm/locator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _splashController = locator.get<SplashController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => Sizes.init(context));

    _splashController.isUserLogged();
    _splashController.addListener(() {
      if (_splashController.state is AuthenticatedUser) {
        Navigator.pushReplacementNamed(
          context,
          NamedRoute.home,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          NamedRoute.initial,
        );
      }
    });
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.greenGradient,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Startcomm',
              style: AppTextStyles.bigText50.copyWith(color: AppColors.white),
            ),
            const CustomCircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
