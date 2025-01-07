import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/constants/app_texts.dart';
import 'package:startcomm/common/widgets/custom_text_form_field.dart';
import 'package:startcomm/common/widgets/multi_text_button.dart';
import 'package:startcomm/common/widgets/password_form_field.dart';
import 'package:startcomm/common/widgets/secondary_button.dart';
import 'package:startcomm/common/utils/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 16.0),
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
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 130.0),
            child: Image.asset(
              'assets/images/sign_up.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: 'Seu Nome',
                  hintText: 'Ely Miranda...',
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
                  labelText: 'Nome da sua Empresa',
                  hintText: 'CoxinhasTop LTDA...',
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
                  labelText: 'Seu Email',
                  hintText: 'exemplo@gmail.com',
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "Digite sua senha",
                  hintText: '********',
                  validator: Validator.validatePassword,
                  helperText: 'Mínimo de 8 caracteres',
                ),
                PasswordFormField(
                  labelText: "Confirme sua senha",
                  hintText: '********',
                  validator: (value) => Validator.validateConfirmPassword(
                    value,
                    _passwordController.text,
                    ),     
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 16.0,
            ),
            child: SecondaryButton(
              text: 'Cadastrar',
              onPressed: () {
                final valid = _formKey.currentState?.validate();
                log(valid.toString());
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