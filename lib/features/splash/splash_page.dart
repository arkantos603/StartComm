import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/constants/app_texts.dart';

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
                  const SizedBox(height: 40), // Espaço entre os textos
                  Text(
                    'Gestão financeira para pequenos negócios ao seu alcance.',
                    style: AppTextsStyles.smallText.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação do botão "Começar"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white, // Fundo white
                    foregroundColor: AppColors.purple, // Cor do texto
                  ),
                  child: Text(
                    'Começar',
                    style: TextStyle(color: AppColors.purple),
                  ),
                ),
                const SizedBox(height: 20), // Espaço entre o botão e o texto
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Já possui uma conta? ',
                      style: AppTextsStyles.smallText.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Ação ao clicar em "Entrar"
                      },
                      child: Text(
                        'Entrar.',
                        style: AppTextsStyles.smallText.copyWith(
                          color: AppColors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}