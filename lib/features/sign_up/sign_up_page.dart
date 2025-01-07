import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/constants/app_texts.dart';
import 'package:startcomm/common/widgets/custon_text_widgets.dart';
import 'package:startcomm/common/widgets/multi_text_button.dart';
import 'package:startcomm/common/widgets/secondary_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:  [
          Text(
            'Comece a Salvar',
            textAlign: TextAlign.center,
            style: AppTextsStyles.mediumText36.copyWith(
              color: AppColors.luzverde2,
            ),
          ),
          Text(
            'O seu Comercio!',
            textAlign: TextAlign.center,
            style: AppTextsStyles.mediumText36.copyWith(
              color: AppColors.luzverde2,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(100.0),
            child: Image.asset(
              'assets/images/sign_up.png',
              fit: BoxFit.contain,
            ),
          ),
          Form(
            child: Column(
              children: const [
                CustonTextFormField(
                  labelText: 'Seu Nome',
                  hintText: 'Ely Miranda...',
                ),
              ],
            )),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 16.0,
            ),
            child: SecondaryButton(
            text: 'Cadastrar',
            onPressed: () => log('tap'),
            ),
          ),
          const SizedBox(height: 16.0),

          MultiTextButton(
            onPressed: () => log('tap'),
            children: [        
          Text(
            'Já possui uma conta?',
            style: AppTextsStyles.smallText.copyWith(
            color: AppColors.blackGrey,
          ),
        ),
          Text(
            ' Entrar',
            style: AppTextsStyles.smallText.copyWith(
            color: AppColors.luzverde2,
          ),
        ),              
        ],          
         ),    
        ],
      ),
    );
  }
}

