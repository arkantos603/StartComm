import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/constants/app_texts.dart';
// import 'package:startcomm/common/widgets/custom_bottom_sheet.dart';
import 'package:startcomm/common/widgets/custom_circular_progress_indicator.dart';
import 'package:startcomm/common/widgets/custom_text_form_field.dart';
import 'package:startcomm/common/widgets/multi_text_button.dart';
import 'package:startcomm/common/widgets/password_form_field.dart';
import 'package:startcomm/common/widgets/secondary_button.dart';
import 'package:startcomm/common/utils/validator.dart';
import 'package:startcomm/features/sign_up/sign_up_controller.dart';
import 'package:startcomm/features/sign_up/sign_up_state.dart';
import 'package:startcomm/services/mock_auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _empresaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = SignUpController(MockAuthService());

  @override
  void dispose() {
    _nameController.dispose();
    _empresaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is SignUpStateLoading) {
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: CustomCircularProgressIndicator(),
          ),
        );
      }
      if (_controller.state is SignUpStateSuccess) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Nova tela'),
              ),
            ),
          ),
        );
      }
      if (_controller.state is SignUpStateError) {
        // final error = (_controller.state as SignUpStateError).message;
        Navigator.pop(context);
        // CustomModalSheetMixin(
        //   context,
        //   content: error.message,
        //   buttonText: "asd",
        // );
      }
    });
  }

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
                  controller: _nameController,
                  labelText: 'Seu Nome',
                  hintText: 'Ely Miranda...',
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
                  controller: _empresaController,
                  labelText: 'Nome da sua Empresa',
                  hintText: 'CoxinhasTop LTDA...',
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
                  controller: _emailController,
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
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.signUp(
                    name: _nameController.text,
                    empresa: _empresaController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                } else {
                  log('erro ao logar');
                }
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
