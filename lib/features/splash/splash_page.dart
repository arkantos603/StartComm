import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/constants/app_texts.dart';
import 'package:startcomm/common/widgets/multi_text_button.dart';
import 'package:startcomm/common/widgets/primary_button.dart';
import 'package:startcomm/features/sign_up/sign_up_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ 
              AppColors.luzverde1,
              AppColors.luzverde2,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'StartComm', 
                    style: AppTextsStyles.bigText.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Gestão financeira para pequenos comercios ao seu alcance.',
                    style: AppTextsStyles.smallText.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 16.0,
            ),
            child: PrimaryButton(
            text: 'Começar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const  SignUpPage(),
                  ),
              );
            },
            ),
          ),
          const SizedBox(height: 16.0),

          MultiTextButton(
            onPressed: () => log('tap'),
            children: [        
          Text(
            'Já possui uma conta?',
            style: AppTextsStyles.smallText.copyWith(
            color: AppColors.white,
          ),
        ),
          Text(
            ' Entrar',
            style: AppTextsStyles.smallText.copyWith(
            color: AppColors.blue,
          ),
        ),              
        ],          
         ),           
          const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
